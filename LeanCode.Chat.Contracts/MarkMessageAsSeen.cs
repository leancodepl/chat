using System;
using LeanCode.CQRS;
using LeanCode.CQRS.Security;

namespace LeanCode.Chat.Contracts
{
    [AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
    public class MarkMessageAsSeen : IRemoteCommand
    {
        public Guid MessageId { get; set; }

        public static class ErrorCodes
        {
            public const int NoMessageId = 1;
        }
    }
}
