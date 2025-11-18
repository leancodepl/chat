using System;
using LeanCode.TimeProvider;

namespace LeanCode.Chat.Services.DataAccess.Entities;

public record ConversationMember
{
    public Guid LastSeenMessageId { get; private init; }
    public DateTime LastSeenMessageDate { get; private init; }
    public long LastSeenMessageCounter { get; private init; }

    public ConversationMember(Guid lastSeenMessageId, DateTime lastSeenMessageDate, long lastSeenMessageCounter)
    {
        LastSeenMessageId = lastSeenMessageId;
        LastSeenMessageDate = lastSeenMessageDate;
        LastSeenMessageCounter = lastSeenMessageCounter;
    }

    public static ConversationMember ForSeenMessage(Message m)
    {
        return new ConversationMember(m.Id, m.DateSent, m.MessageCounter);
    }

    public static ConversationMember Empty()
    {
        var now = Time.UtcNow;
        return new ConversationMember(Guid.Empty, now, Message.UnavailableCounterValue);
    }
}
