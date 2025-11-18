using System;
using System.Collections.Generic;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts
{
    [AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
    public class CreateConversation : ICommand
    {
        public Guid ConversationId { get; set; }
        public HashSet<Guid> Members { get; set; } = null!;
        public Dictionary<string, string>? Metadata { get; set; }

        public static class ErrorCodes
        {
            public const int NoMembers = 1;
            public const int CannotCreateConversation = 2;
        }
    }
}
