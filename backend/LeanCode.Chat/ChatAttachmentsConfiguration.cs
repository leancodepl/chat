using System;

namespace LeanCode.Chat;

public sealed record ChatAttachmentsConfiguration
{
    public string ContainerPrefix { get; init; } = "chat";
    public TimeSpan DownloadSasTokenValidity { get; init; } = TimeSpan.FromHours(24);
    public TimeSpan UploadSasTokenValidity { get; init; } = TimeSpan.FromMinutes(15);
}
