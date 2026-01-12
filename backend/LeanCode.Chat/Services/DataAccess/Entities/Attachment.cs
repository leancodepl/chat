using System;

namespace LeanCode.Chat.Services.DataAccess.Entities;

public class Attachment
{
    public Uri Uri { get; private set; } = null!;
    public string MimeType { get; private set; } = null!;
    public string FileName { get; private set; } = null!;

    private Attachment() { }

    public Attachment(Uri uri, string mimeType, string fileName)
    {
        Uri = uri;
        MimeType = mimeType;
        FileName = fileName;
    }
}
