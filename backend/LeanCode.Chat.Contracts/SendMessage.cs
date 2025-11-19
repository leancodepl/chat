using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class SendMessage : ICommand
{
    public Guid MessageId { get; set; }
    public Guid ConversationId { get; set; }
    public string Content { get; set; } = null!;

    public static class ErrorCodes
    {
        public const int ConversationDoesNotExist = 1;
        public const int UserNotInConversation = 2;
        public const int NoContent = 3;
        public const int NoMessageId = 4;
        public const int CannotSendMessage = 5;
    }
}
