using System;
using System.Collections.Generic;
using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class SendMessage : ICommand
{
    public Guid MessageId { get; set; }
    public Guid ConversationId { get; set; }
    public string? Content { get; set; }
    public List<AttachmentDTO>? Attachments { get; set; }

    public static class ErrorCodes
    {
        public const int ConversationDoesNotExist = 1;
        public const int UserNotInConversation = 2;
        public const int NoContent = 3;
        public const int NoMessageId = 4;
        public const int CannotSendMessage = 5;
        public const int OneOfContentOrAttachmentsRequired = 6;
        public const int InvalidAttachment = 7;
    }
}
