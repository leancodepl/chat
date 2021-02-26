using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;

namespace LeanCode.Chat.Services.DataAccess.Notifications
{
    public interface IChatPushNotificationsLocalizer
    {
        Task<Dictionary<Guid, CultureInfo>> GetUserLocales(List<Guid> userIds);
        Task<Dictionary<CultureInfo, Notification>> LocalizeNewMessageNotification(NewMessageNotificationData data, List<CultureInfo> locales);
    }

    public record NewMessageNotificationData
    {
        public Guid SenderId { get; init; }
        public string Content { get; init; } = null!;
        public IReadOnlyDictionary<string, string> ConversationMetadata { get; init; } = new Dictionary<string, string>();
    }
}
