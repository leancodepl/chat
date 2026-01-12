using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Azure.Storage.Sas;

namespace LeanCode.Chat.Services.DataAccess.Blobs;

public class ChatAttachmentsBlobStorage
{
    private const string DeleteTagName = "ToDelete";
    private const string DeleteValue = "1";

    private readonly BlobServiceClient client;
    private readonly BlobStorageDelegationKeyProvider keyProvider;
    private readonly ChatAttachmentsConfiguration config;

    public ChatAttachmentsBlobStorage(
        BlobServiceClient client,
        BlobStorageDelegationKeyProvider keyProvider,
        ChatAttachmentsConfiguration config
    )
    {
        this.client = client;
        this.keyProvider = keyProvider;
        this.config = config;
    }

    public async Task<Uri> GetUploadUrlAsync(
        Guid conversationId,
        Guid messageId,
        string fileName,
        CancellationToken cancellationToken
    )
    {
        var containerName = GetContainerName(conversationId);
        var container = client.GetBlobContainerClient(containerName);
        await container.CreateIfNotExistsAsync(cancellationToken: cancellationToken);

        var blobName = $"{messageId}/{Guid.NewGuid()}{Path.GetExtension(fileName)}";
        var blob = container.GetBlobClient(blobName);

        await blob.UploadAsync(
            Stream.Null,
            new BlobUploadOptions { Tags = new Dictionary<string, string> { [DeleteTagName] = DeleteValue } },
            cancellationToken
        );

        var sasBuilder = new BlobSasBuilder
        {
            BlobContainerName = containerName,
            BlobName = blobName,
            Resource = "b",
            ExpiresOn = DateTimeOffset.UtcNow.Add(config.UploadSasTokenValidity),
        };
        sasBuilder.SetPermissions(BlobSasPermissions.Write);

        var key = await keyProvider.GetKeyAsync(cancellationToken);
        var sasToken = sasBuilder.ToSasQueryParameters(key, client.AccountName);

        return new Uri($"{blob.Uri}?{sasToken}");
    }

    public async Task<(string SasToken, DateTimeOffset ExpiresAt)> GetDownloadTokenAsync(
        Guid conversationId,
        CancellationToken cancellationToken
    )
    {
        var containerName = GetContainerName(conversationId);
        var expiresAt = DateTimeOffset.UtcNow.Add(config.DownloadSasTokenValidity);

        var sasBuilder = new BlobSasBuilder
        {
            BlobContainerName = containerName,
            Resource = "c",
            ExpiresOn = expiresAt,
        };
        sasBuilder.SetPermissions(BlobContainerSasPermissions.Read | BlobContainerSasPermissions.List);

        var key = await keyProvider.GetKeyAsync(cancellationToken);
        var sasToken = sasBuilder.ToSasQueryParameters(key, client.AccountName).ToString();

        return (sasToken, expiresAt);
    }

    public async Task CommitBlobAsync(Uri blobUri, CancellationToken cancellationToken)
    {
        var blob = new BlobClient(blobUri);
        await blob.SetTagsAsync(new Dictionary<string, string>(), cancellationToken: cancellationToken);
    }

    public bool IsValidBlobUri(Guid conversationId, Uri uri)
    {
        var blobBuilder = new BlobUriBuilder(uri);
        var containerName = GetContainerName(conversationId);

        return blobBuilder.AccountName == client.AccountName
            && blobBuilder.BlobContainerName == containerName
            && IsValidBlobName(blobBuilder.BlobName);
    }

    private bool IsValidBlobName(string blobName)
    {
        var parts = blobName.Split('/');
        return parts.Length == 2 && Guid.TryParse(parts[0], out _) && Guid.TryParse(parts[1], out _);
    }

    private string GetContainerName(Guid conversationId) => $"{config.ContainerPrefix}-{conversationId}";
}
