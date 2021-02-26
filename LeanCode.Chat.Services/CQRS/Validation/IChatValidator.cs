using System;
using System.Threading;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;

namespace LeanCode.Chat.Services.CQRS.Validation
{
    public interface IChatValidator
    {
        Task<bool> CanCreateConversationAsync(Guid userId, CreateConversation command, CancellationToken cancellationToken);
    }

    public class EmptyChatValidator : IChatValidator
    {
        public Task<bool> CanCreateConversationAsync(Guid userId, CreateConversation command, CancellationToken cancellationToken)
        {
            return Task.FromResult(true);
        }
    }
}
