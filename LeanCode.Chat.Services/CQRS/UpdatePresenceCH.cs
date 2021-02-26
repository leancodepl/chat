using System.Threading.Tasks;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Execution;

namespace LeanCode.Chat.Services.CQRS
{
    public class UpdatePresenceCH : ICommandHandler<ChatContext, UpdatePresence>
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<UpdatePresenceCH>();
        private readonly ChatStorage storage;

        public UpdatePresenceCH(ChatStorage storage)
        {
            this.storage = storage;
        }

        public async Task ExecuteAsync(ChatContext context, UpdatePresence command)
        {
            var userId = context.UserId;

            await storage.UpdateUserPresence(userId);

            logger.Information("Refreshed presence for user {UserId}", userId);
        }
    }
}
