using System;
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
        }
    }

    public class SendMessageCH : ICommandHandler<ChatContext, SendMessage>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<SendMessageCH>();
        private readonly ChatStorage storage;

        public SendMessageCH(ChatStorage storage)
        {
            this.storage = storage;
        }

        public async Task ExecuteAsync(ChatContext context, SendMessage command)
        {
            var userId = context.UserId;
            var conv = await storage.GetConversationAsync(command.ConversationId);

            if (conv is null)
            {
                throw new InvalidOperationException("Conversation does not exist");
            }

            if (!conv.InConversation(userId))
            {
                throw new InvalidOperationException("User is not in conversation");
            }

            var message = Message.Create(command.MessageId, conv, userId, command.Content);
            var updatedMember = conv.Members[userId].ForSeenMessage(message);

            await storage.AddMessageAsync(message, updatedMember);

            logger.Information("User {UserId} sent message to conversation {ConversationId}", userId, conv.Id);
        }
    }
}
