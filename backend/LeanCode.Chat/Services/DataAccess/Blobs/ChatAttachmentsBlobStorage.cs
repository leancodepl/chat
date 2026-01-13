using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Azure.Storage.Sas;
using LeanCode.Logging;

namespace LeanCode.Chat.Services.DataAccess.Blobs;

public class ChatAttachmentsBlobStorage
{
    private const string DeleteTagName = "ToDelete";
    private const string DeleteValue = "1";

    private readonly BlobServiceClient client;
    private readonly BlobStorageDelegationKeyProvider keyProvider;
    private readonly ChatAttachmentsConfiguration config;
    private readonly ILogger<ChatAttachmentsBlobStorage> logger;

    public ChatAttachmentsBlobStorage(
        BlobServiceClient client,
        BlobStorageDelegationKeyProvider keyProvider,
        ChatAttachmentsConfiguration config,
        ILogger<ChatAttachmentsBlobStorage> logger
    )
    {
        this.client = client;
        this.keyProvider = keyProvider;
        this.config = config;
        this.logger = logger;
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

        try
        {
            var key = await keyProvider.GetKeyAsync(cancellationToken);
            var sasToken = sasBuilder.ToSasQueryParameters(key, client.AccountName);

            return new Uri($"{blob.Uri}?{sasToken}");
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error getting upload URL");

            // Fallback to account key

            if (client.CanGenerateAccountSasUri)
            {
                return blob.GenerateSasUri(sasBuilder);
            }

            throw;
        }
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

        try
        {
            var key = await keyProvider.GetKeyAsync(cancellationToken);
            var sasToken = sasBuilder.ToSasQueryParameters(key, client.AccountName).ToString();

            return (sasToken, expiresAt);
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error getting download token");
            // Fallback to account key
            if (client.CanGenerateAccountSasUri)
            {
                var container = client.GetBlobContainerClient(containerName);
                return (container.GenerateSasUri(sasBuilder).ToString(), expiresAt);
            }

            throw;
        }
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
        if (parts.Length != 2 || !Guid.TryParse(parts[0], out _))
        {
            return false;
        }

        var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(parts[1]);
        return Guid.TryParse(fileNameWithoutExtension, out _);
    }

    private string GetContainerName(Guid conversationId) => $"{config.ContainerPrefix}-{conversationId}";
}
