using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Blobs;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.Extensions.DependencyInjection;

namespace LeanCode.Chat;

public static class ChatServiceProviderExtensions
{
    public static void AddLeanChat(
        this IServiceCollection services,
        ChatConfiguration chatConfig,
        GuidUserIdExtractor userIdExtractor,
        ChatAttachmentsConfiguration attachmentsConfig
    )
    {
        services.AddTransient<ChatService>();

        services.AddSingleton(userIdExtractor);
        services.AddSingleton(chatConfig);
        services.AddSingleton(attachmentsConfig);
        services.AddSingleton<BlobStorageDelegationKeyProvider>();
        services.AddTransient<ChatAttachmentsBlobStorage>();
    }
}
