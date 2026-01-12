using System;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess.Blobs;
using LeanCode.CQRS.Execution;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;

namespace LeanCode.Chat.Services.CQRS;

public class ConversationAttachmentsTokenQH
    : IQueryHandler<ConversationAttachmentsToken, ConversationAttachmentsTokenDTO>
{
    private readonly ChatAttachmentsBlobStorage blobStorage;
    private readonly IChatValidator validator;
    private readonly GuidUserIdExtractor userIdExtractor;

    public ConversationAttachmentsTokenQH(
        ChatAttachmentsBlobStorage blobStorage,
        IChatValidator validator,
        GuidUserIdExtractor userIdExtractor
    )
    {
        this.blobStorage = blobStorage;
        this.validator = validator;
        this.userIdExtractor = userIdExtractor;
    }

    public async Task<ConversationAttachmentsTokenDTO> ExecuteAsync(
        HttpContext context,
        ConversationAttachmentsToken query
    )
    {
        var userId = userIdExtractor.Extract(context.User);
        var canAccess = await validator.CanAccessConversationAttachmentsAsync(userId, query, context.RequestAborted);

        if (!canAccess)
        {
            throw new InvalidOperationException("User cannot access attachments for this conversation.");
        }

        var (sasToken, expiresAt) = await blobStorage.GetDownloadTokenAsync(
            query.ConversationId,
            context.RequestAborted
        );

        return new ConversationAttachmentsTokenDTO { SasToken = sasToken, ExpiresAt = expiresAt };
    }
}
