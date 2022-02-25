using System;
using LeanCode.Time;

namespace LeanCode.Chat.Services.DataAccess.Entities
{
    public record ConversationMember
    {
        public Guid LastDeliveredMessageId { get; private init; }
        public DateTime LastDeliveredMessageDate { get; private init; }
        public Guid LastSeenMessageId { get; private init; }
        public DateTime LastSeenMessageDate { get; private init; }

        public ConversationMember(
            Guid lastDeliveredMessageId,
            DateTime lastDeliveredMessageDate,
            Guid lastSeenMessageId,
            DateTime lastSeenMessageDate)
        {
            LastDeliveredMessageId = lastDeliveredMessageId;
            LastDeliveredMessageDate = lastDeliveredMessageDate;
            LastSeenMessageId = lastSeenMessageId;
            LastSeenMessageDate = lastSeenMessageDate;
        }

        public ConversationMember ForDeliveredMessage(Message m)
        {
            return this with
            {
                LastDeliveredMessageId = m.Id,
                LastSeenMessageDate = m.DateSent,
            };
        }

        public ConversationMember ForSeenMessage(Message m)
        {
            return this with
            {
                LastDeliveredMessageId = m.Id,
                LastDeliveredMessageDate = m.DateSent,
                LastSeenMessageId = m.Id,
                LastSeenMessageDate = m.DateSent,
            };
        }

        public static ConversationMember Empty()
        {
            var now = TimeProvider.Now;
            return new ConversationMember(
                Guid.Empty,
                now,
                Guid.Empty,
                now);
        }
    }
}
