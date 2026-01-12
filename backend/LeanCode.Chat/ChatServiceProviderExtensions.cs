using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Blobs;
using Microsoft.Extensions.DependencyInjection;

namespace LeanCode.Chat;

public static class ChatServiceProviderExtensions
{
    public static void AddLeanChat(this IServiceCollection services, ChatAttachmentsConfiguration attachmentsConfig)
    {
        services.AddTransient<ChatService>();

        services.AddSingleton(attachmentsConfig);
        services.AddSingleton<BlobStorageDelegationKeyProvider>();
        services.AddTransient<ChatAttachmentsBlobStorage>();
    }
}
