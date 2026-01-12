# LeanCode.Chat

## Infrastructure

LeanCode.Chat is based on Firestore. You need to set up the whole Firebase infrastructure before using it. The rest of the documentation assumes that Firestore has been configured in the project with help of the `LeanCode.Firebase.Firestore` NuGet package. Remember to set proper security rules from `firestore.rules` and index exception rules from `firestore.indexes.json`.

## Limitations

Although the model supports group conversations, they will not scale well due to the low throughput of Firestore (1 document write/second). **It is recommended to use this chat only for 1-1 conversations** or perform performance testing before deciding on using in a project where conversations are to have more than 2 members. Another limit which can cause problems is that the maximum number of items for `IN` queries is just 10 (which can be circumvented by manual batching).

## Basic setup

To add chat to your project, install the NuGet package and modify `Startup.cs`:

```csharp
// Startup.cs

using LeanCode.Chat;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.DataAccess.Events;

// ...

public class Startup : LeanStartup
{
    private static readonly TypesCatalog AllHandlers = new TypesCatalog(
        typeof(CoreContext),
        typeof(ChatContext));

    private static readonly TypesCatalog Events = new TypesCatalog(
        typeof(CoreContext),
        typeof(MessageSent));

    // ...

    var modules = new List<IAppModule>
    {
        new CQRSModule()
            .WithCustomPipelines<CoreContext>(
                new TypesCatalog(typeof(CoreContext)),
                c => c.Trace().Secure().Validate().StoreAndPublishEvents(),
                q => q.Trace().Secure().Cache())
            .WithCustomPipelines<ChatContext>(
                new TypesCatalog(typeof(ChatContext)),
                c => c.Trace().Secure().Validate().StoreAndPublishEvents(),
                q => q.Trace().Secure().Cache()),
        /// ...
        new ChatModule(),
    }

    /// ...

        app.Map("/chat", api => api
            // .UseAuthentication() if appropriate
            .UseUserIdLogsCorrelation(DefaultChatClaims.UserId)
            .UseRemoteCQRS(
                new TypesCatalog(typeof(CreateConversation)),
                ChatContext.FromHttp));
    // ...
}
```

### Configuration

`ChatConfiguration` should be registered in your `AppModule` at least with default values:

```csharp
protected override void Load(ContainerBuilder builder)
{
    // ...
    builder.RegisterInstance(new ChatConfiguration()).AsSelf().SingleInstance();
}
```

### Authorization

Access to the chat is protected by the `chat_user` permission. Add it to your app roles to allow specified groups of users to use the chat.

```csharp
public IEnumerable<Role> Roles { get; } = new[]
{
    new Role(R.User, R.User, ChatRoles.ChatUser),
    new Role(R.Admin, R.Admin, R.User, ChatRoles.ChatUser),
};
```

### Creating conversations

The task of checking if users should be able to start conversations with other users is delegated to the core application domain. Appropriate rules should be specified by implementing the `IChatValidator` interface:

```csharp
public interface IChatValidator
{
    Task<bool> CanCreateConversationAsync(Guid userId, CreateConversation command, CancellationToken cancellationToken);
}
```

Injecting `ChatService` might be useful for querying the underlying chat database.

### Custom data

LeanCode.Chat by design does not explicitly hold any app-specific data in its storage (including user data like usernames, avatars etc.)

#### User data

Client apps can annotate conversations with user data by calling a query with a list of user ids. It could look like this:

```csharp
[AuthorizeWhenHasAnyOf(Roles.User)]
public class ChatUsers : IRemoteQuery<List<ChatUserDTO>>
{
    public List<Guid> UserIds { get; set; }
}
```

The DTO model can differ between applications and has no direct coupling to the chat subdomain. It is a responsibility of client library to merge those two sources of data together to display them on the UI.

#### Conversation data

It is also possible to annotate the whole conversation with some application-specific data. This allows e.g. having multiple conversations between the same users in different contexts (think e.g. orders in marketplaces). You can add any metadata to conversations via the `Metadata` field in the `CreateConversation` command. Typically, you would store there ids of some domain objects, but there are no restrictions on what can be held in conversation metadata. Remember to check the validity of metadata provided by the client in `ChatValidator`.

Due to the way Firestore indexes work, **if you want to query by a specific nullable metadata property, it cannot be empty - it needs to be explicitly set to null**.

To enable clients to query application-specific conversation data, you should expose a query similar to the one for users:

```csharp
[AuthorizeWhenHasAnyOf(Roles.User)]
public class ChatAuctions : IRemoteQuery<List<ChatAuctionDTO>>
{
    public List<Guid> AuctionIds { get; set; }
}
```

### Push notifications

LeanCode.Chat is set up to send push notifications to users assuming the project has FCM configured with the help of the `LeanCode.Chat.FCM` package. Push notifications can be localized on a per-user basis which means the core application project should implement `IChatPushNotificationsLocalizer`. The interface also provides flexibility of setting the title of the notification e.g. based on the conversation metadata.

You can opt out from sending default notification by setting `SendNotificationOnNewMessage` property in `ChatConfiguration` to `false`.

## Chat Attachments

LeanCode.Chat supports image, video, and file attachments in messages using Azure Blob Storage with User Delegation Keys for secure access.

### Setup Requirements

#### 1. Azure Blob Storage Configuration

You must register a `BlobServiceClient` configured with Entra ID (Managed Identity or Service Principal):

```csharp
services.AddAzureClients(cfg =>
{
    cfg.AddBlobServiceClient(SharedAppConfig.BlobStorage.ConnectionString(Configuration));
});
```

#### 2. Chat Service Registration

Pass `ChatAttachmentsConfiguration` to `AddLeanChat`:

```csharp
services.AddLeanChat(new ChatAttachmentsConfiguration
{
    ContainerPrefix = "chat",                              // Blob container prefix
    DownloadSasTokenValidity = TimeSpan.FromHours(24),    // Download token validity
    UploadSasTokenValidity = TimeSpan.FromMinutes(15)     // Upload token validity
});
```

#### 3. Azure RBAC Permissions

The Managed Identity or Service Principal must have the following role:

- **Storage Blob Data Contributor** (for issuing User Delegation Keys)

### How It Works

1. **Upload Flow:**
   - Client requests upload URL via `AttachmentUploadUrl` query
   - Backend generates SAS URL with write permissions and tags blob with `ToDelete=1`
   - Client uploads directly to Azure Blob Storage
   - Client sends message with attachment URIs via `SendMessage` command
   - Backend removes `ToDelete` tag to commit the attachment

2. **Download Flow:**
   - Client requests container SAS token via `ConversationAttachmentsToken` query
   - Backend validates user access and generates container-level SAS token
   - Client downloads attachments directly from Azure Blob Storage

### Blob Cleanup Strategy

Uncommitted blobs (tagged with `ToDelete=1`) should be cleaned up periodically.

**Recommended:** Configure Azure Lifecycle Management policy:

```json
{
  "rules": [{
    "name": "DeleteUncommittedChatAttachments",
    "enabled": true,
    "type": "Lifecycle",
    "definition": {
      "filters": {
        "blobTypes": ["blockBlob"],
        "prefixMatch": ["chat-"],
        "blobIndexMatch": [{"name": "ToDelete", "value": "1"}]
      },
      "actions": {
        "baseBlob": {
          "delete": {"daysAfterModificationGreaterThan": 1}
        }
      }
    }
  }]
}
```

This policy automatically deletes uncommitted attachments after 24 hours.

## CHANGELOG

- **`Message.Content` starting from version 10.0.2709-preview.42 is now nullable**: Messages can have either `Content`, `Attachments`, or both
