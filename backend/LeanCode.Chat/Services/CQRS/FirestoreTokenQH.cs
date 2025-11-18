using System.Threading.Tasks;
using FirebaseAdmin;
using FirebaseAdmin.Auth;
using LeanCode.Chat.Contracts;
using LeanCode.CQRS.Execution;
using LeanCode.UserIdExtractors.Extractors;
using Microsoft.AspNetCore.Http;

namespace LeanCode.Chat.Services.CQRS;

public class FirestoreTokenQH : IQueryHandler<FirestoreToken, string>
{
    private readonly FirebaseApp app;
    private readonly GuidUserIdExtractor userIdExtractor;

    public FirestoreTokenQH(FirebaseApp app, GuidUserIdExtractor userIdExtractor)
    {
        this.app = app;
        this.userIdExtractor = userIdExtractor;
    }

    public Task<string> ExecuteAsync(HttpContext context, FirestoreToken query)
    {
        var auth = FirebaseAuth.GetAuth(app);
        return auth.CreateCustomTokenAsync(userIdExtractor.Extract(context.User).ToString());
    }
}
