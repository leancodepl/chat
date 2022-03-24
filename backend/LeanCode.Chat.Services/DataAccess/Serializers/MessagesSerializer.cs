using System;
using System.Collections.Generic;
using Google.Cloud.Firestore;
using LeanCode.Chat.Services.DataAccess.Entities;

namespace LeanCode.Chat.Services.DataAccess.Serializers
{
    internal static class MessagesSerializer
    {
        public static object SerializeMessage(Message m)
        {
            return new
            {
                SenderId = m.SenderId.ToString(),
                ConversationId = m.ConversationId.ToString(),
                m.MessageCounter,

                m.DateSent,
                m.Content,
            };
        }

        public static Message? DeserializeMessage(DocumentSnapshot doc)
        {
            if (!doc.Exists)
            {
                return null;
            }

            var id = Guid.Parse(doc.Id);
            var conversationId = Guid.Parse(doc.GetValue<string>(nameof(Message.ConversationId)));
            var senderId = Guid.Parse(doc.GetValue<string>(nameof(Message.SenderId)));
            var dateSent = doc.GetValue<DateTime>(nameof(Message.DateSent));
            var content = doc.GetValue<string>(nameof(Message.Content));
            doc.TryGetValue<long?>(nameof(Message.MessageCounter), out var msgCounter);

            return new Message(
                id,
                conversationId,
                senderId,
                dateSent,
                msgCounter ?? Message.UnavailableCounterValue,
                content);
        }

        public static Message? DeserializeMessage(Dictionary<string, object> map)
        {
            var id = Guid.Parse((map?[nameof(Message.Id)] as string)!);
            var conversationId = Guid.Parse((map?[nameof(Message.ConversationId)] as string)!);
            var senderId = Guid.Parse((map?[nameof(Message.SenderId)] as string)!);
            var dateSent = ((Timestamp)map?[nameof(Message.DateSent)]!).ToDateTime();
            var content = (map?[nameof(Message.Content)] as string)!;
            var msgCounter = GetMessageCounter(map);

            return new Message(
                id,
                conversationId,
                senderId,
                dateSent,
                msgCounter,
                content);
        }

        private static long GetMessageCounter(Dictionary<string, object>? map)
        {
            if (map is not null)
            {
                map.TryGetValue(nameof(Message.MessageCounter), out var lastSeenMessageCounter);
                return lastSeenMessageCounter is long v ? v : Message.UnavailableCounterValue;
            }
            else
            {
                return Message.UnavailableCounterValue;
            }
        }
    }
}
