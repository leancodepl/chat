using System.Collections.Generic;
using LeanCode.Chat.Contracts.Notifications;
using LeanCode.Firebase.FCM;

namespace LeanCode.Chat.Services.DataAccess.Services;

public class NotificationsMapper
{
    private static readonly NotificationDataConverter NotificationDataConverter = NotificationDataConverter
        .New()
        .Build();

    public static Dictionary<string, string> ToNotificationData(NewMessageNotificationContentDTO content)
    {
        var data = NotificationDataConverter.ToNotificationData(content);
        data.Remove("Type");

        return data;
    }
}
