using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Blobs;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.Logging;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;
using Errors = LeanCode.Chat.Contracts.SendMessage.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS;

public class SendMessageCV : AbstractValidator<SendMessage>
{
    public SendMessageCV()
    {
        ClassLevelCascadeMode = CascadeMode.Stop;

        RuleFor(cmd => cmd.MessageId).NotEmpty().WithCode(Errors.NoMessageId).WithMessage("No message id");

        RuleFor(cmd => cmd.ConversationId).CustomAsync(ValidateConversationAsync);

        RuleFor(cmd => cmd)
            .Must(cmd => !string.IsNullOrWhiteSpace(cmd.Content) || (cmd.Attachments?.Count ?? 0) > 0)
            .WithCode(Errors.OneOfContentOrAttachmentsRequired)
            .WithMessage("Message must have either content or attachments");

        RuleFor(cmd => cmd).Custom(ValidateAttachments);

        RuleFor(cmd => cmd)
            .MustAsync(CanSendMessageAsync)
            .WithCode(Errors.CannotSendMessage)
            .WithMessage("Cannot send message");
    }

    private static void ValidateAttachments(SendMessage cmd, ValidationContext<SendMessage> ctx)
    {
        if (cmd.Attachments is not null && cmd.Attachments.Count > 0)
        {
            var blobStorage = ctx.GetService<ChatAttachmentsBlobStorage>();

            if (!cmd.Attachments.All(a => a.Uri is not null && a.FileName is not null && a.MimeType is not null))
            {
                ctx.AddValidationError("Attachments list contains null elements", Errors.InvalidAttachment);
            }

            if (!cmd.Attachments.All(a => blobStorage.IsValidBlobUri(cmd.ConversationId, a.Uri)))
            {
                ctx.AddValidationError("Attachment URI does not belong to this conversation", Errors.InvalidAttachment);
            }
        }
    }

    private static Task<bool> CanSendMessageAsync(
        SendMessage cmd,
        SendMessage _,
        IValidationContext ctx,
        CancellationToken cancellationToken
    )
    {
        var userId = ctx.GetService<GuidUserIdExtractor>().Extract(ctx.HttpContext().User);
        var validator = ctx.GetService<IChatValidator>();

        return validator.CanSendMessageAsync(userId, cmd, cancellationToken);
    }

    private static async Task ValidateConversationAsync(
        Guid id,
        ValidationContext<SendMessage> ctx,
        CancellationToken cancellationToken
    )
    {
        var userId = ctx.GetService<GuidUserIdExtractor>().Extract(ctx.HttpContext().User);
        var conv = await ctx.GetService<ChatService>().GetConversationAsync(id);

        if (conv is null)
        {
            ctx.AddValidationError("Conversation does not exist", Errors.ConversationDoesNotExist);
        }
        else if (!conv.InConversation(userId))
        {
            ctx.AddValidationError("User is not in conversation", Errors.UserNotInConversation);
        }
    }
}

public class SendMessageCH : ICommandHandler<SendMessage>
{
    private readonly ILogger<SendMessageCH> logger;
    private readonly ChatService storage;
    private readonly GuidUserIdExtractor userIdExtractor;
    private readonly ChatAttachmentsBlobStorage blobStorage;

    public SendMessageCH(
        ChatService storage,
        GuidUserIdExtractor userIdExtractor,
        ChatAttachmentsBlobStorage blobStorage,
        ILogger<SendMessageCH> logger
    )
    {
        this.storage = storage;
        this.userIdExtractor = userIdExtractor;
        this.blobStorage = blobStorage;
        this.logger = logger;
    }

    public async Task ExecuteAsync(HttpContext context, SendMessage command)
    {
        var userId = userIdExtractor.Extract(context.User);

        var attachments = command.Attachments?.Select(a => new Attachment(a.Uri, a.MimeType, a.FileName)).ToList();

        var data = await storage.AddMessageAsync(
            command.ConversationId,
            conv => conv.WriteMessage(command.MessageId, userId, command.Content, attachments),
            conv => conv.InConversation(userId)
        );

        if (data is (Conversation conv, Message msg))
        {
            if (msg.Attachments is not null)
            {
                foreach (var attachment in msg.Attachments)
                {
                    await blobStorage.CommitBlobAsync(attachment.Uri, context.RequestAborted);
                }
            }

            msg.NotifySent(conv);

            logger.Information("User {UserId} sent message to conversation {ConversationId}", userId, conv.Id);
        }
        else
        {
            logger.Warning(
                "Cannot send the message {MessageId} to conversation {ConversationId} because the conversation does not exist",
                command.MessageId,
                command.ConversationId
            );
        }
    }
}
