namespace LeanCode.Chat.Contracts.Notifications;

public abstract record ChatNotificationContent
{
    public abstract ChatNotificationTypeDTO ChatNotificationType { get; }
}

public enum ChatNotificationTypeDTO
{
    NewMessage = 1,
}
