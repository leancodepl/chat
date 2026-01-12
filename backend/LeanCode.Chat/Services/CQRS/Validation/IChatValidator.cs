using System;
using System.Threading;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;

namespace LeanCode.Chat.Services.CQRS.Validation;

public interface IChatValidator
{
    public Task<bool> CanCreateConversationAsync(
        Guid userId,
        CreateConversation command,
        CancellationToken cancellationToken
    ) => Task.FromResult(true);

    public Task<bool> CanSendMessageAsync(Guid userId, SendMessage command, CancellationToken cancellationToken) =>
        Task.FromResult(true);

    public Task<bool> CanUploadAttachmentAsync(
        Guid userId,
        AttachmentUploadUrl query,
        CancellationToken cancellationToken
    ) => Task.FromResult(true);

    public Task<bool> CanAccessConversationAttachmentsAsync(
        Guid userId,
        ConversationAttachmentsToken query,
        CancellationToken cancellationToken
    ) => Task.FromResult(true);
}

public class EmptyChatValidator : IChatValidator { }
