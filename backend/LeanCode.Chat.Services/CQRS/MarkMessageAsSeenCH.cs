using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;
using Errors = LeanCode.Chat.Contracts.MarkMessageAsSeen.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS
{
    public class MarkMessageAsSeenCV : AbstractValidator<MarkMessageAsSeen>
    {
        public MarkMessageAsSeenCV()
        {
            ClassLevelCascadeMode = CascadeMode.Stop;

            RuleFor(cmd => cmd.MessageId).NotEmpty().WithCode(Errors.NoMessageId).WithMessage("No message id");
        }
    }

    public class MarkMessageAsSeenCH : ICommandHandler<MarkMessageAsSeen>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<MarkMessageAsSeenCH>();
        private readonly ChatService storage;
        private readonly GuidUserIdExtractor userIdExtractor;

        public MarkMessageAsSeenCH(ChatService storage, GuidUserIdExtractor userIdExtractor)
        {
            this.storage = storage;
            this.userIdExtractor = userIdExtractor;
        }

        public async Task ExecuteAsync(HttpContext context, MarkMessageAsSeen command)
        {
            var userId = userIdExtractor.Extract(context.User);
            var message = await storage.GetMessageAsync(command.MessageId);

            if (message is null)
            {
                logger.Information(
                    "User {UserId} attempted to mark a non-existing message {MessageId}, ignoring",
                    userId,
                    command.MessageId
                );
                return;
            }

            await storage.UpdateMemberLastSeenMessageAsync(
                userId,
                message,
                (conv, msg) =>
                {
                    if (!conv.InConversation(userId))
                    {
                        logger.Information(
                            "User {UserId} attempted to access messages from conversation {ConversationId} they do not belong to, ignoring",
                            userId,
                            conv.Id
                        );
                        return false;
                    }
                    else
                    {
                        var member = conv.Members[userId];
                        return member.LastSeenMessageCounter < message.MessageCounter;
                    }
                }
            );
        }
    }
}
