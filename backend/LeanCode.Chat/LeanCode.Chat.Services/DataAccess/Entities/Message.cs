using System;
using LeanCode.Chat.Services.DataAccess.Events;
using LeanCode.DomainModels.Model;
using LeanCode.TimeProvider;

namespace LeanCode.Chat.Services.DataAccess.Entities
{
    public class Message
    {
        public const int UnavailableCounterValue = -1;

        public Guid Id { get; private set; }
        public Guid ConversationId { get; private set; }
        public Guid SenderId { get; private set; }
        public DateTime DateSent { get; private set; }
        public long MessageCounter { get; private set; }
        public string Content { get; private set; } = null!;

        private Message() { }

        // For firestore & tests
        internal Message(
            Guid id,
            Guid conversationId,
            Guid senderId,
            DateTime dateSent,
            long messageCounter,
            string content
        )
        {
            Id = id;
            ConversationId = conversationId;
            SenderId = senderId;
            DateSent = dateSent;
            MessageCounter = messageCounter;
            Content = content;
        }

        internal static Message Create(Guid guid, Guid conversationId, Guid senderId, long nextCounter, string content)
        {
            return new(guid, conversationId, senderId, Time.UtcNow, nextCounter, content);
        }

        public void NotifySent(Conversation conversation)
        {
            if (conversation.Id != ConversationId)
            {
                throw new ArgumentException("The message belongs to different conversation.");
            }

            DomainEvents.Raise(new MessageSent(this, conversation));
        }
    }
}
