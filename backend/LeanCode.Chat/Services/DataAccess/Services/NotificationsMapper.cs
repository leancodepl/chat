using System.Collections.Generic;
using LeanCode.Chat.Contracts.Notifications;

namespace LeanCode.Chat.Services.DataAccess.Services;

public class NotificationsMapper
{
    public static Dictionary<string, string> ToNotificationData(NewMessageNotificationContentDTO content)
    {
        var data = Firebase.FCM.Notifications.ToNotificationData(content);
        data.Remove("Type");

        return data;
    }
}
