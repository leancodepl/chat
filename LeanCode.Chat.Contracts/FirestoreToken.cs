using LeanCode.CQRS;
using LeanCode.CQRS.Security;

namespace LeanCode.Chat.Contracts
{
    [AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
    public class FirestoreToken : IRemoteQuery<string>
    {
    }
}
