using System;
using LeanCode.Chat.Services.DataAccess.Events;
using LeanCode.DomainModels.Model;
using LeanCode.Time;

namespace LeanCode.Chat.Services.DataAccess.Entities
{
    public class Message
    {
        public Guid Id { get; private set; }
        public Guid ConversationId { get; private set; }
        public Guid SenderId { get; private set; }
        public DateTime DateSent { get; private set; }
        public string Content { get; private set; } = null!;

        private Message() { }

        // For firestore & tests
        internal Message(
            Guid id, Guid conversationId, Guid senderId,
            DateTime dateSent, string content)
        {
            Id = id;
            ConversationId = conversationId;
            SenderId = senderId;
            DateSent = dateSent;
            Content = content;
        }

        public static Message Create(Guid guid, Conversation conversation, Guid senderId, string content)
        {
            var message = new Message(
                guid,
                conversation.Id,
                senderId,
                TimeProvider.Now,
                content);

            DomainEvents.Raise(new MessageSent(message, conversation));

            return message;
        }
    }
}
