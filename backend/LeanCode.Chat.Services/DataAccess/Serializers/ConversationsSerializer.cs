using System;
using System.Collections.Generic;
using System.Linq;
using Google.Cloud.Firestore;
using LeanCode.Chat.Services.DataAccess.Entities;

namespace LeanCode.Chat.Services.DataAccess.Serializers
{
    internal static class ConversationsSerializer
    {
        public static object SerializeNewConversation(Conversation c)
        {
            return new
            {
                c.Metadata,
                Members = c.Members.ToDictionary(
                    pair => pair.Key.ToString(),
                    pair => SerializeConversationMember(pair.Value)),

                // To facilite clients queries for data
                LastMessage = new { Exists = false },
                Timestamp = FieldValue.ServerTimestamp,
                MemberIds = c.Members.Keys
                    .Select(m => m.ToString())
                    .ToList(),
            };
        }

        public static object SerializeConversationMember(ConversationMember member)
        {
            return new
            {
                LastDeliveredMessageId = member.LastDeliveredMessageId.ToString(),
                LastSeenMessageId = member.LastSeenMessageId.ToString(),

                member.LastDeliveredMessageDate,
                member.LastSeenMessageDate,

                // To enable queries checking all members ids
                Exists = true,
            };
        }

        public static object SerializeMemberUpdate(Guid id, ConversationMember member)
        {
            return new
            {
                Members = new Dictionary<string, object>
                {
                    [id.ToString()] = SerializeConversationMember(member),
                },
                Timestamp = FieldValue.ServerTimestamp,
            };
        }

        public static object SerializeConversationUpdateForNewMessage(Message message, ConversationMember updatedSender)
        {
            return new
            {
                LastMessage = new
                {
                    Id = message.Id.ToString(),
                    SenderId = message.SenderId.ToString(),
                    ConversationId = message.ConversationId.ToString(),
                    message.DateSent,
                    message.Content,

                    // For queries
                    Exists = true,
                },
                Members = new Dictionary<string, object>
                {
                    [message.SenderId.ToString()] = SerializeConversationMember(updatedSender),
                },
                Timestamp = FieldValue.ServerTimestamp,
            };
        }

        public static Conversation? DeserializeConversation(DocumentSnapshot doc)
        {
            if (!doc.Exists)
            {
                return null;
            }

            var id = Guid.Parse(doc.Id);

            var members = doc.GetValue<Dictionary<string, object>>(nameof(Conversation.Members))
                .ToDictionary(
                    pair => Guid.Parse(pair.Key),
                    pair => DeserializeConversationMember(pair.Value));

            var metadata = doc.GetValue<Dictionary<string, string>>(nameof(Conversation.Metadata));

            doc.TryGetValue<Dictionary<string, object>>(nameof(Conversation.LastMessage), out var lastMessageRaw);

            Message? lastMessage = null;
            if (lastMessageRaw["Exists"] as bool? == true)
            {
                lastMessage = MessagesSerializer.DeserializeMessage(lastMessageRaw);
            }

            return new Conversation(
                id,
                members,
                lastMessage,
                metadata);
        }

        public static ConversationMember DeserializeConversationMember(object data)
        {
            var map = data as Dictionary<string, object>;
            var lastDeliveredId = Guid.Parse((map?[nameof(ConversationMember.LastDeliveredMessageId)] as string)!);
            var lastDeliveredDate = ((Timestamp)map?[nameof(ConversationMember.LastDeliveredMessageDate)]!).ToDateTime();
            var lastSeenId = Guid.Parse((map?[nameof(ConversationMember.LastSeenMessageId)] as string)!);
            var lastSeenDate = ((Timestamp)map?[nameof(ConversationMember.LastSeenMessageDate)]!).ToDateTime();

            return new ConversationMember(
                lastDeliveredId,
                lastDeliveredDate,
                lastSeenId,
                lastSeenDate);
        }
    }
}
