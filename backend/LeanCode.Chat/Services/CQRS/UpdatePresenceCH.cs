using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;
using LeanCode.Chat.Contracts;
using LeanCode.Chat.Services.DataAccess;
using LeanCode.CQRS.Execution;
using LeanCode.Logging;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;

namespace LeanCode.Chat.Services.CQRS;

[SuppressMessage("", "LNCD0003", Justification = "There is nothing to validate.")]
public class UpdatePresenceCH : ICommandHandler<UpdatePresence>
{
    private readonly ILogger<UpdatePresenceCH> logger;
    private readonly ChatService storage;
    private readonly GuidUserIdExtractor userIdExtractor;

    public UpdatePresenceCH(ChatService storage, GuidUserIdExtractor userIdExtractor, ILogger<UpdatePresenceCH> logger)
    {
        this.storage = storage;
        this.userIdExtractor = userIdExtractor;
        this.logger = logger;
    }

    public async Task ExecuteAsync(HttpContext context, UpdatePresence command)
    {
        var userId = userIdExtractor.Extract(context.User);

        await storage.UpdateUserPresence(userId);

        logger.Information("Refreshed presence for user {UserId}", userId);
    }
}
