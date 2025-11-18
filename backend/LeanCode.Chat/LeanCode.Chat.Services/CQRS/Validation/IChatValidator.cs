using System;
using System.Threading;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;

namespace LeanCode.Chat.Services.CQRS.Validation
{
    public interface IChatValidator
    {
        Task<bool> CanCreateConversationAsync(
            Guid userId,
            CreateConversation command,
            CancellationToken cancellationToken
        ) => Task.FromResult(true);

        Task<bool> CanSendMessageAsync(Guid userId, SendMessage command, CancellationToken cancellationToken) =>
            Task.FromResult(true);
    }

    public class EmptyChatValidator : IChatValidator { }
}
