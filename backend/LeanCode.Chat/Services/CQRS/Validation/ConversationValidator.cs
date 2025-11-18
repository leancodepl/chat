using System;
using System.Threading.Tasks;
using FluentValidation;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Validation.Fluent;
using LeanCode.UserIdExtractors.Extractors;

namespace LeanCode.Chat.Services.CQRS.Validation;

public class ConversationValidator : AbstractValidator<Guid>
{
    public ConversationValidator(int notExistsCode, int userNotInConversationCode)
    {
        RuleFor(id => id)
            .CustomAsync((id, ctx, _) => ValidateConversationAsync(id, ctx, notExistsCode, userNotInConversationCode));
    }

    private static async Task ValidateConversationAsync(
        Guid id,
        ValidationContext<Guid> ctx,
        int notExistsCode,
        int userNotInConversationCode
    )
    {
        var userId = ctx.GetService<GuidUserIdExtractor>().Extract(ctx.HttpContext().User);
        var conv = await ctx.GetService<ChatService>().GetConversationAsync(id);

        if (conv is null)
        {
            ctx.AddValidationError("Conversation does not exist", notExistsCode);
        }
        else if (!conv.InConversation(userId))
        {
            ctx.AddValidationError("User is not in conversation", userNotInConversationCode);
        }
    }
}
