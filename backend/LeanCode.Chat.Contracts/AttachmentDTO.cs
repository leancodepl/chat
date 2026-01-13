using System;

namespace LeanCode.Chat.Contracts;

public class AttachmentDTO
{
    public Uri Uri { get; set; }
    public string MimeType { get; set; }
    public string FileName { get; set; }
}
