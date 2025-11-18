using Google.Cloud.Firestore;

namespace LeanCode.Chat.Services.DataAccess.Serializers;

internal static class UserPresenceSerializer
{
    public static object SerializeUserPresence()
    {
        return new { LastSeen = FieldValue.ServerTimestamp };
    }
}
