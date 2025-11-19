using LeanCode.Contracts;
using LeanCode.Contracts.Security;

namespace LeanCode.Chat.Contracts;

[AuthorizeWhenHasAnyOf(ChatRoles.ChatUser)]
public class FirestoreToken : IQuery<string> { }
