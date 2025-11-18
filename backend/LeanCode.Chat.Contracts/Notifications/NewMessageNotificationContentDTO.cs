using System;

namespace LeanCode.Chat.Contracts.Notifications;

public record NewMessageNotificationContentDTO : ChatNotificationContent
{
    public override ChatNotificationTypeDTO ChatNotificationType => ChatNotificationTypeDTO.NewMessage;

    public Guid ConversationId { get; private init; }
    public Guid MessageId { get; private init; }

    private NewMessageNotificationContentDTO() { }

    public static NewMessageNotificationContentDTO Create(Guid conversationId, Guid messageId)
    {
        return new NewMessageNotificationContentDTO { ConversationId = conversationId, MessageId = messageId };
    }
}
