# leancode_chat_client

## Basic setup

First, construct a new instance of `CQRS` to use with the chat:

```dart
final chatCQRS = CQRS(
  loginClient,
  config.apiUri.resolve('/chat/'),
);
```

## Custom data

Chat uses multiple data sources:

- the main is Firestore which holds all conversation members, messages, counters etc.
- user data and potential application-specific data related to conversations should be exposed via custom core application queries

`leancode_chat_client` takes care of combining those two sources of data into one, so the only thing to do is to define custom data types and implement `ChatCustomDataProvider`:

```dart

@freezed
class ChatMember with _$ChatMember {
  const factory ChatMember({
    required String id,
    required String name,
    required String avatarUrl,
    required String? location,
    required bool isCurrentUser,
  }) = _ChatMember;
}

@freezed
class ChatConversation with _$ChatConversation {
  const factory ChatConversation({
    required String orderName,
  }) = _ChatConversation;
}

class ChatRepository extends BaseRepository
    implements ChatCustomProvider<ChatMember, ChatConversation> {
  const ChatRepository(CQRS cqrs) : super(cqrs);

  @override
  Future<Map<String, ChatConversation>> fetchConversationData(
    List<ConversationIntermediate> conversations,
  ) async {
      // fetch conversation data from the API and map it to ChatConversation
  }

  @override
  Future<Map<String, ChatMember>> fetchMembersData(
    List<String> userIds,
    String currentUserId,
  ) async {
      // fetch user data from the API and map it to ChatMember
  }
}
```

With that, you can create an instance of `ChatClient` which is the main class for interacting with the chat:

```dart
RepositoryProvider<ChatClient<ChatMember, ChatConversation>>(
    create: (context) => ChatClient<ChatMember, ChatConversation>(
      chatCqrs,
      context.read<ChatRepository>(),
  ),
)
```

## Authentication

Call `ChatClient.signIn()` and `ChatClient.signOut()` in appropriate places to authenticate users with Firebase.

## Conversations

To fetch all conversations call `ChatClient.fetchAllConversations()`. Pagination is not yet supported, but it shouldn't be hard to add it with Firestore `limit` queries. On a conversation list screen you would also probably want to call `ChatClient.subscribeToConversationUpdates` to listen to any real-time updates to conversations (updating last message text, showing new conversations etc.)

List of messages for a given conversation is paginated and can be loaded with `ChatClient.fetchMessages`. To subscribe to all new messages for a conversation call `ChatClient.subscribeToNewMessages`.

Call `ChatClient.markMessageAsSeen` whenever opening a conversation screen with unread messages and when receiving a new message when that screen is opened.

### Contextual conversations

Contextual conversations (conversations related to some core domain object) are possible with the conversation metadata. You can for example fetch a conversation with a user related to some order like so:

```dart
_chatClient.fetchConversationByMetadata(
  members: [_userId],
  metadataProperty: 'OrderId',
  metadataValue: _orderId,
);
```

## Counters

To manage state of unread conversation counters, provide an instance of `UnreadConversationsCounterCubit`:

```dart
BlocProvider<UnreadConversationsCounterCubit>(
    lazy: false,
    create: (context) => UnreadConversationsCounterCubit(
      context.read<ChatClient>(),
    ),
),
```

## User presence

### Tracking current user presence

To track current user's presence use a provided hook `useUserPresence`. It will periodically update the online status as long as the app is opened in the foreground. You typically would like to call it on the highest possible level (main screen of the app).

```dart
useUserPresence(
    context.read<ChatClient>(),
    WidgetsBinding.instance,
);
```

### Tracking other users presence

```dart
BlocProvider<UsersPresenceCubit>(
    create: (context) => UsersPresenceCubit(
      context.read<ChatClient>(),
    ),
),
```

To start tracking users presence call `subscribeToUsersPresence` on the cubit. You should call it whenever a screen is opened which needs to show other users' activity (on conversations list, user profile page etc.)

```dart
context.read<UsersPresenceCubit>()
  .subscribeToUsersPresence(userIds);
```

Remember to unsubscribe when you no longer need to display users' activity:

```dart
usersPresenceState.unsubscribeFromAll();
```

### Push notifications

This assumes you have already configured FCM in the project.

#### Navigation

`ChatNotificationsParser` class provides some utils for dealing with push notifications related to chat and extracting information passed in the payload. For example, a simple implementation of a `RouterHandler` which would redirect to the conversation screen after clicking on a new message notification could look like this:

```dart
class ChatNotificationHandler extends RouterHandler {
  @override
  bool canHandle(dynamic result) {
    if (result is! FcmMessage) {
      return false;
    }

    final message = result as FcmMessage;
    return ChatNotificationsParser.isChatNotification(message.data));
  }

  @override
  Page handle(dynamic originalResult) {
    final message = originalResult as FcmMessage;

    final conversationId =
        ChatNotificationsParser.extractConversationId(message.data);

    return ConversationScreenPage(conversationId);
  }
}
```

#### Foreground notifications

If you want to show push notifications in the foreground as well, you will need to use the `flutter_local_notifications` pub package (it needs to be at least v4.0.0-dev.1, more specifically [functionality from this PR](https://github.com/MaikuB/flutter_local_notifications/pull/983) is required).

Because possibilities of customizing the behavior of foreground notifications on iOS in FCM are very limited, it is necessary to disable the default way of handling them and use `flutter_local_notifications` to build them manually instead:

```dart
// Disable default iOS heads up notifications from
// Firebase, we'll build them ourselves
fcm.setForegroundNotificationPresentationOptions();

localNotificationsPlugin.initialize(
  const InitializationSettings(
    android: AndroidInitializationSettings('ic_stat_ic_notification'),
    iOS: IOSInitializationSettings(
      defaultPresentSound: false,
      defaultPresentBadge: false,
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    ),
  ),
  onSelectNotification: selectNotificationCallback,
);
```

For grouping chat notifications `tag`s and `threadIdentifier`s are used on Android and iOS respectively. They are passed in remote messages sent by the backend, but in the case of foreground notifications they need to be set manually.

```dart
FirebaseMessaging.onMessage.listen((message) {
  if (!notificationsFilter.shouldShowNotification(message)) {
    return;
  }

  final notification = message.notification;

  String? tag;
  if (ChatNotificationsParser.isChatNotification(message.data)) {
    tag = ChatNotificationsParser.extractConversationId(message.data);
  }

  if (notification != null) {
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _fcmNotificationChannel.id,
          _fcmNotificationChannel.name,
          _fcmNotificationChannel.description,
          icon: notification.android?.smallIcon ?? 'ic_stat_ic_notification',
          color: TruffleBoardColors.primary,
          tag: tag,
        ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentSound: false,
          presentBadge: false,
          sound: 'default',
          threadIdentifier: tag,
        ),
      ),
      payload: json.encode(message.data),
    );
  }
});
```

Most probably you don't want to show push notifications on a conversation screen. You can implement a simple filter for foreground notifications to only show notification not related to the current conversation with a custom `NavigatorObserver` and `ChatNotificationsParser`.

```dart

class ForegroundNotificationsFilter extends NavigatorObserver {
  Route? _currentRoute;
  String? _conversationId;

  bool shouldShowNotification(RemoteMessage message) {
    if (_currentRoute is ConversationScreenRoute &&
        ChatNotificationsParser.isChatNotification(message.data)) {
      final messageConversationId =
          ChatNotificationsParser.extractConversationId(message.data);

      return messageConversationId != _conversationId;
    }

    return true;
  }

  void enableConversationNotifications() {
    _conversationId = null;
  }

  void disableNotificationsForConversation(String conversationId) {
    _conversationId = conversationId;
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _currentRoute = previousRoute;
  }

  @override
  void didPush(Route route, Route previousRoute) {
    _currentRoute = route;
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    _currentRoute = previousRoute;
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    _currentRoute = newRoute;
  }
}
```
