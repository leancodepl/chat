using System;
using LeanCode.CQRS;
using LeanCode.CQRS.Security;

namespace LeanCode.Chat.Contracts
{
    [AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
    public class SendMessage : IRemoteCommand
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
}
