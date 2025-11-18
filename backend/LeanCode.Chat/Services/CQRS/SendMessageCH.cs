using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;
using Errors = LeanCode.Chat.Contracts.SendMessage.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS
{
    public class SendMessageCV : AbstractValidator<SendMessage>
    {
        public SendMessageCV()
        {
            ClassLevelCascadeMode = CascadeMode.Stop;

            RuleFor(cmd => cmd.MessageId).NotEmpty().WithCode(Errors.NoMessageId).WithMessage("No message id");

            RuleFor(cmd => cmd.ConversationId)
                .SetValidator(new ConversationValidator(Errors.ConversationDoesNotExist, Errors.UserNotInConversation));

            RuleFor(cmd => cmd.Content).NotEmpty().WithCode(Errors.NoContent).WithMessage("No content");

            RuleFor(cmd => cmd)
                .MustAsync(ValidateCommandAsync)
                .WithCode(Errors.CannotSendMessage)
                .WithMessage("Cannot send message");
        }

        private static Task<bool> ValidateCommandAsync(
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
    }

    public class SendMessageCH : ICommandHandler<SendMessage>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<SendMessageCH>();
        private readonly ChatService storage;
        private readonly GuidUserIdExtractor userIdExtractor;

        public SendMessageCH(ChatService storage, GuidUserIdExtractor userIdExtractor)
        {
            this.storage = storage;
            this.userIdExtractor = userIdExtractor;
        }

        public async Task ExecuteAsync(HttpContext context, SendMessage command)
        {
            var userId = userIdExtractor.Extract(context.User);

            var data = await storage.AddMessageAsync(
                command.ConversationId,
                conv => conv.WriteMessage(command.MessageId, userId, command.Content),
                conv => conv.InConversation(userId)
            );

            if (data is not null)
            {
                var (conv, msg) = data.Value;
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
}
