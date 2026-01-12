using System;

namespace LeanCode.Chat.Contracts;

public class AttachmentDTO
{
    public Uri Uri { get; set; } = null!;
    public string MimeType { get; set; } = null!;
    public string FileName { get; set; } = null!;
}
