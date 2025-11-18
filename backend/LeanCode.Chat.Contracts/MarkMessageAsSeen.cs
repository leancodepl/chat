using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts
{
    [AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
    public class MarkMessageAsSeen : ICommand
    {
        public Guid MessageId { get; set; }

        public static class ErrorCodes
        {
            public const int NoMessageId = 1;
        }
    }
}
