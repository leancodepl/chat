using System;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess.Blobs;
using LeanCode.CQRS.Execution;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;

namespace LeanCode.Chat.Services.CQRS;

public class AttachmentUploadUrlQH : IQueryHandler<AttachmentUploadUrl, Uri>
{
    private readonly ChatAttachmentsBlobStorage blobStorage;
    private readonly IChatValidator validator;
    private readonly GuidUserIdExtractor userIdExtractor;

    public AttachmentUploadUrlQH(
        ChatAttachmentsBlobStorage blobStorage,
        IChatValidator validator,
        GuidUserIdExtractor userIdExtractor
    )
    {
        this.blobStorage = blobStorage;
        this.validator = validator;
        this.userIdExtractor = userIdExtractor;
    }

    public async Task<Uri> ExecuteAsync(HttpContext context, AttachmentUploadUrl query)
    {
        var userId = userIdExtractor.Extract(context.User);
        var canUpload = await validator.CanUploadAttachmentAsync(userId, query, context.RequestAborted);

        if (!canUpload)
        {
            throw new InvalidOperationException("User cannot upload attachment to this conversation.");
        }

        return await blobStorage.GetUploadUrlAsync(
            query.ConversationId,
            query.MessageId,
            query.FileName,
            context.RequestAborted
        );
    }
}
