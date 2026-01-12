using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class ConversationAttachmentsToken : IQuery<ConversationAttachmentsTokenDTO>
{
    public Guid ConversationId { get; set; }
}

public class ConversationAttachmentsTokenDTO
{
    public string SasToken { get; set; } = null!;
    public DateTimeOffset ExpiresAt { get; set; }
}
