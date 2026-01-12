using System;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class AttachmentUploadUrl : IQuery<Uri>
{
    public Guid ConversationId { get; set; }
    public Guid MessageId { get; set; }
    public string FileName { get; set; } = null!;
    public string MimeType { get; set; } = null!;

    public static class ErrorCodes
    {
        public const int ConversationDoesNotExist = 1;
        public const int UserNotInConversation = 2;
        public const int NoFileName = 3;
        public const int NoMimeType = 4;
        public const int NoMessageId = 5;
    }
}
