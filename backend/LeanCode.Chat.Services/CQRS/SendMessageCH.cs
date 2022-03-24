using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using Errors = LeanCode.Chat.Contracts.SendMessage.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS
{
    public class SendMessageCV : ContextualValidator<SendMessage>
    {
        public SendMessageCV()
        {
            CascadeMode = CascadeMode.Stop;

            RuleFor(cmd => cmd.MessageId)
                .NotEmpty()
                .WithCode(Errors.NoMessageId)
                .WithMessage("No message id");

            RuleFor(cmd => cmd.ConversationId)
                .SetValidator(new ConversationValidator(
                    Errors.ConversationDoesNotExist,
                    Errors.UserNotInConversation));

            RuleFor(cmd => cmd.Content)
                .NotEmpty()
                .WithCode(Errors.NoContent)
                .WithMessage("No content");

            RuleForAsync(cmd => cmd, ValidateCommandAsync)
                .Equal(true)
                .WithCode(Errors.CannotSendMessage)
                .WithMessage("Cannot send message");
        }

        private static Task<bool> ValidateCommandAsync(
            IValidationContext ctx,
            SendMessage cmd)
        {
            var chatContext = ctx.AppContext<ChatContext>();
            var validator = ctx.GetService<IChatValidator>();

            return validator.CanSendMessageAsync(chatContext.UserId, cmd, chatContext.CancellationToken);
        }
    }

    public class SendMessageCH : ICommandHandler<ChatContext, SendMessage>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<SendMessageCH>();
        private readonly ChatService storage;

        public SendMessageCH(ChatService storage)
        {
            this.storage = storage;
        }

        public async Task ExecuteAsync(ChatContext context, SendMessage command)
        {
            var userId = context.UserId;

            var data = await storage.AddMessageAsync(
                command.ConversationId,
                conv => conv.WriteMessage(command.MessageId, userId, command.Content),
                conv => conv.InConversation(userId));

            if (data is not null)
            {
                var (conv, msg) = data.Value;
                msg.NotifySent(conv);

                logger.Information(
                    "User {UserId} sent message to conversation {ConversationId}",
                    userId, conv.Id);
            }
            else
            {
                logger.Warning(
                    "Cannot send the message {MessageId} to conversation {ConversationId} because the conversation does not exist",
                    command.MessageId, command.ConversationId);
            }
        }
    }
}
