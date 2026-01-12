using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class ConversationAttachmentsToken : IQuery<ConversationAttachmentsTokenDTO>
{
    public Guid ConversationId { get; set; }

    public static class ErrorCodes
    {
        public const int ConversationDoesNotExist = 1;
        public const int UserNotInConversation = 2;
    }
}

public class ConversationAttachmentsTokenDTO
{
    public string SasToken { get; set; } = null!;
    public DateTime ExpiresAt { get; set; }
}
