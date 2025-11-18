using Google.Cloud.Firestore;

namespace LeanCode.Chat.Services.DataAccess.Serializers;

internal static class ConversationCountersSerializer
{
    public static object SerializeConversationCounterIncrement()
    {
        return new { Count = FieldValue.Increment(1) };
    }

    public static object SerializeConversationCounterDecrement()
    {
        return new { Count = FieldValue.Increment(-1) };
    }
}
