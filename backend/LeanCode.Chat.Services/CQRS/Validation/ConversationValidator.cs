using System;
using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Validation.Fluent;

namespace LeanCode.Chat.Services.CQRS.Validation
{
    public class ConversationValidator : ContextualValidator<Guid>
    {
        public ConversationValidator(
            int notExistsCode,
            int userNotInConversationCode)
        {
            RuleForAsync(id => id, ValidateConversationAsync)
                .Cascade(CascadeMode.Stop)
                .Must(e => e.Exists)
                    .WithCode(notExistsCode)
                    .WithMessage("Conversation does not exist")
                .Must(e => e.IsMember)
                    .WithCode(userNotInConversationCode)
                    .WithMessage("User is not in conversation");
        }

        private static async Task<(bool Exists, bool IsMember)> ValidateConversationAsync(
            IValidationContext ctx,
            Guid conversationId)
        {
            var userId = ctx.AppContext<ChatContext>().UserId;
            var conv = await ctx.GetService<ChatStorage>()
                .GetConversationAsync(conversationId);

            return (
                conv != null,
                conv?.InConversation(userId) ?? false);
        }
    }
}
