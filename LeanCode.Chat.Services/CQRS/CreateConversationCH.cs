using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using Errors = LeanCode.Chat.Contracts.CreateConversation.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS
{
    public class CreateConversationCV : ContextualValidator<CreateConversation>
    {
        public CreateConversationCV()
        {
            CascadeMode = CascadeMode.Stop;

            RuleFor(cmd => cmd.Members)
                .NotEmpty()
                .WithCode(Errors.NoMembers)
                .WithMessage("No conversation members");

            RuleForAsync(cmd => cmd, ValidateCommandAsync)
                .Equal(true)
                .WithCode(Errors.CannotCreateConversation)
                .WithMessage("Cannot create conversation");
        }

        private static Task<bool> ValidateCommandAsync(
            IValidationContext ctx,
            CreateConversation cmd)
        {
            var chatContext = ctx.AppContext<ChatContext>();
            var validator = ctx.GetService<IChatValidator>();

            return validator.CanCreateConversationAsync(chatContext.UserId, cmd, chatContext.CancellationToken);
        }
    }

    public class CreateConversationCH : ICommandHandler<ChatContext, CreateConversation>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<CreateConversationCH>();
        private readonly ChatStorage storage;

        public CreateConversationCH(ChatStorage storage)
        {
            this.storage = storage;
        }

        public async Task ExecuteAsync(ChatContext context, CreateConversation command)
        {
            var conv = Conversation.Create(command.ConversationId, command.Members, command.Metadata);
            await storage.AddConversationAsync(conv);
            logger.Information("Conversation {ConversationId} created", conv.Id);
        }
    }
}
