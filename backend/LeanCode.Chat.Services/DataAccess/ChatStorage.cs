using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Google.Cloud.Firestore;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.Chat.Services.DataAccess.Serializers;
using LeanCode.Chat.Services.DataAccess.Services;
using LeanCode.Firebase.Firestore;

namespace LeanCode.Chat.Services.DataAccess
{
    public partial class ChatStorage
    {
        private readonly FirestoreDatabase db;

        public ChatStorage(FirestoreDatabase db)
        {
            this.db = db;
        }

        public virtual async Task<Conversation?> GetConversationAsync(Guid conversationId)
        {
            var snap = await db.Database.Conversation(conversationId).GetSnapshotAsync();
            return ConversationsSerializer.DeserializeConversation(snap);
        }

        public virtual async Task<Conversation?> GetConversationAsync(HashSet<Guid> members, string metadataProperty, string? metadataValue)
        {
            var query = db.Database.Conversations()
                .WhereEqualTo($"{nameof(Conversation.Metadata)}.{metadataProperty}", metadataValue);

            foreach (var member in members)
            {
                query = query.WhereEqualTo($"{nameof(Conversation.Members)}.{member}.Exists", true);
            }

            var snap = await query.Limit(1)
                .GetSnapshotAsync();

            if (snap.Count == 0)
            {
                return null;
            }

            return ConversationsSerializer.DeserializeConversation(snap.Documents[0]);
        }

        public virtual async Task<Message?> GetMessageAsync(Guid messageId)
        {
            var snap = await db.Database.Message(messageId).GetSnapshotAsync();
            return MessagesSerializer.DeserializeMessage(snap);
        }

        public virtual Task AddConversationAsync(Conversation c)
        {
            var doc = db.Database.Conversation(c.Id);
            return doc.CreateAsync(ConversationsSerializer.SerializeNewConversation(c));
        }

        public virtual async Task AddMessageAsync(Message message, ConversationMember updatedMember)
        {
            var msgDoc = db.Database.Message(message.Id);
            var convDoc = db.Database.Conversation(message.ConversationId);

            await db.Database.RunTransactionAsync(async transaction =>
            {
                var convSnapshot = await transaction.GetSnapshotAsync(convDoc);
                var conversation = ConversationsSerializer.DeserializeConversation(convSnapshot);
                if (conversation is null)
                {
                    return false;
                }

                transaction.Create(msgDoc, MessagesSerializer.SerializeMessage(message));
                transaction.Set(convDoc, ConversationsSerializer.SerializeConversationUpdateForNewMessage(message, updatedMember), SetOptions.MergeAll);

                var membersIdsToUpdate = ConversationCountersService.GetMemberIdsForIncrementOnNewMessage(conversation, message);
                foreach (var memberId in membersIdsToUpdate)
                {
                    transaction.Set(
                        db.Database.UnreadConversationCounter(memberId),
                        ConversationCountersSerializer.SerializeConversationCounterIncrement(),
                        SetOptions.MergeAll);
                }

                return true;
            });
        }

        public virtual async Task UpdateMemberLastSeenMessageAsync(Guid conversationId, Guid userId, ConversationMember member, Message message)
        {
            var newMember = member.ForSeenMessage(message);
            var doc = db.Database.Conversation(conversationId);

            await db.Database.RunTransactionAsync(async transaction =>
            {
                var convSnapshot = await transaction.GetSnapshotAsync(doc);
                var conversation = ConversationsSerializer.DeserializeConversation(convSnapshot);
                if (conversation is null)
                {
                    return false;
                }

                if (ConversationCountersService.ShouldDecrementCounterOnMessageSeen(conversation, userId, message.Id))
                {
                    transaction.Set(
                        db.Database.UnreadConversationCounter(userId),
                        ConversationCountersSerializer.SerializeConversationCounterDecrement(),
                        SetOptions.MergeAll);
                }

                transaction.Set(doc, ConversationsSerializer.SerializeMemberUpdate(userId, newMember), SetOptions.MergeAll);

                return true;
            });
        }

        public async Task UpdateUserPresence(Guid userId)
        {
            var doc = db.Database.UserPresence(userId);
            await doc.SetAsync(UserPresenceSerializer.SerializeUserPresence());
        }
    }
}
