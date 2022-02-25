using System.Threading.Tasks;
using FirebaseAdmin;
using FirebaseAdmin.Auth;
using LeanCode.Chat.Contracts;
using LeanCode.CQRS.Execution;

namespace LeanCode.Chat.Services.CQRS
{
    public class FirestoreTokenQH : IQueryHandler<ChatContext, FirestoreToken, string>
    {
        private readonly FirebaseApp app;

        public FirestoreTokenQH(FirebaseApp app)
        {
            this.app = app;
        }

        public Task<string> ExecuteAsync(ChatContext context, FirestoreToken query)
        {
            var auth = FirebaseAuth.GetAuth(app);
            return auth.CreateCustomTokenAsync(context.UserId.ToString());
        }
    }
}
