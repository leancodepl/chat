using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.CQRS.Validation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.CQRS.Execution;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;
using Errors = LeanCode.Chat.Contracts.CreateConversation.ErrorCodes;

namespace LeanCode.Chat.Services.CQRS
{
    public class CreateConversationCV : AbstractValidator<CreateConversation>
    {
        public CreateConversationCV()
        {
            ClassLevelCascadeMode = CascadeMode.Stop;

            RuleFor(cmd => cmd.Members).NotEmpty().WithCode(Errors.NoMembers).WithMessage("No conversation members");

            RuleFor(cmd => cmd)
                .MustAsync(ValidateCommandAsync)
                .WithCode(Errors.CannotCreateConversation)
                .WithMessage("Cannot create conversation");
        }

        private static Task<bool> ValidateCommandAsync(
            CreateConversation cmd,
            CreateConversation _,
            IValidationContext ctx,
            CancellationToken cancellationToken
        )
        {
            var userId = ctx.GetService<GuidUserIdExtractor>().Extract(ctx.HttpContext().User);
            var validator = ctx.GetService<IChatValidator>();

            return validator.CanCreateConversationAsync(userId, cmd, cancellationToken);
        }
    }

    public class CreateConversationCH : ICommandHandler<CreateConversation>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<CreateConversationCH>();
        private readonly ChatService storage;

        public CreateConversationCH(ChatService storage)
        {
            this.storage = storage;
        }

        public async Task ExecuteAsync(HttpContext context, CreateConversation command)
        {
            var conv = Conversation.Create(command.ConversationId, command.Members, command.Metadata);
            await storage.AddConversationAsync(conv);
            logger.Information("Conversation {ConversationId} created", conv.Id);
        }
    }
}
