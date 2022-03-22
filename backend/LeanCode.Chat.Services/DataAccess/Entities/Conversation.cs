using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using LeanCode.Chat.Services.DataAccess.Events;
using LeanCode.DomainModels.Model;

namespace LeanCode.Chat.Services.DataAccess.Entities
{
    public class Conversation
    {
        private Dictionary<Guid, ConversationMember> members;
        private Dictionary<string, string> metadata;

        public Guid Id { get; private set; }
        public IReadOnlyDictionary<string, string> Metadata => metadata;
        public IReadOnlyDictionary<Guid, ConversationMember> Members => members;
        public Message? LastMessage { get; private set; }

        public long NextMessageCounter { get; private set; }

        public bool InConversation(Guid userId) => Members.ContainsKey(userId);

        public bool TryGetMember(Guid userId, [NotNullWhen(true)] out ConversationMember? member)
        {
            return Members.TryGetValue(userId, out member);
        }

        public bool HasUnreadMessages(Guid userId)
        {
            if (!TryGetMember(userId, out var member))
            {
                throw new InvalidOperationException("Member does not exist");
            }

            return LastMessage != null && LastMessage.Id != member.LastSeenMessageId;
        }

        private Conversation()
        {
            members = new();
            metadata = new();
        }

        // For firestore & tests
        internal Conversation(
            Guid id,
            Dictionary<Guid, ConversationMember> members,
            Message? lastMessage,
            Dictionary<string, string> metadata,
            long nextMessageCounter)
        {
            Id = id;
            this.members = members;
            this.metadata = metadata;
            LastMessage = lastMessage;
            NextMessageCounter = nextMessageCounter;
        }

        public static Conversation Create(Guid id, IEnumerable<Guid> members, Dictionary<string, string>? metadata = null)
        {
            var conversation = new Conversation
            {
                Id = id,
                members = members.ToDictionary(m => m, _ => ConversationMember.Empty()),
                LastMessage = null,
                metadata = metadata ?? new Dictionary<string, string>(),
            };

            DomainEvents.Raise(new ConversationCreated(conversation));

            return conversation;
        }

        public Message WriteMessage(Guid guid, Guid senderId, string content)
        {
            return Message.Create(guid, Id, senderId,  NextMessageCounter, content);
        }
    }
}
