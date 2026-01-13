using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class AttachmentUploadUrl : IQuery<Uri>
{
    public Guid ConversationId { get; set; }
    public Guid MessageId { get; set; }
    public string FileName { get; set; }
    public string MimeType { get; set; }
}
