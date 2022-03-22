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
    public class ChatService
    {
        private readonly Serilog.ILogger logger = Serilog.Log.ForContext<ChatService>();

        private readonly FirestoreDatabase db;

        public ChatService(FirestoreDatabase db)
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

        public virtual async Task<(Conversation, Message)?> AddMessageAsync(
            Guid conversationId,
            Func<Conversation, Message> createFreshMessage,
            Func<Conversation, bool> validateAction)
        {
            return await db.Database.RunTransactionAsync<(Conversation, Message)?>(async transaction =>
            {
                var convDoc = db.Database.Conversation(conversationId);

                var convSnapshot = await transaction.GetSnapshotAsync(convDoc);
                var conversation = ConversationsSerializer.DeserializeConversation(convSnapshot);

                if (conversation is null)
                {
                    logger.Information(
                        "Cannot send new message to conversation {ConversationId}, the conversation does not exist",
                        conversationId);
                    return null;
                }

                if (!validateAction(conversation))
                {
                    logger.Information(
                        "Cannot send new message to conversation {ConversationId}, the validation did not pass",
                        conversationId);
                    return null;
                }

                var message = createFreshMessage(conversation);
                var msgDoc = db.Database.Message(message.Id);

                var updatedMember = ConversationMember.ForSeenMessage(message);

                transaction.Create(msgDoc, MessagesSerializer.SerializeMessage(message));
                transaction.Set(convDoc, ConversationsSerializer.SerializeConversationUpdateForNewMessage(message, updatedMember), SetOptions.MergeAll);

                var membersIdsToIncrement = ConversationCountersService.GetMemberIdsForIncrementOnNewMessage(conversation, message);
                foreach (var memberId in membersIdsToIncrement)
                {
                    transaction.Set(
                        db.Database.UnreadConversationCounter(memberId),
                        ConversationCountersSerializer.SerializeConversationCounterIncrement(),
                        SetOptions.MergeAll);
                }

                var membersIdsToDecrement = ConversationCountersService.GetMemberIdsForDecrementOnNewMessage(conversation, message);
                foreach (var memberId in membersIdsToDecrement)
                {
                    transaction.Set(
                        db.Database.UnreadConversationCounter(memberId),
                        ConversationCountersSerializer.SerializeConversationCounterDecrement(),
                        SetOptions.MergeAll);
                }

                return (conversation, message);
            });
        }

        public virtual async Task UpdateMemberLastSeenMessageAsync(
            Guid userId,
            Message message,
            Func<Conversation, Message, bool> validateAction)
        {
            var doc = db.Database.Conversation(message.ConversationId);

            await db.Database.RunTransactionAsync(async transaction =>
            {
                var convSnapshot = await transaction.GetSnapshotAsync(doc);
                var conversation = ConversationsSerializer.DeserializeConversation(convSnapshot);

                if (conversation is null)
                {
                    logger.Information(
                        "Cannot mark message {Message} as read in conversation {ConversationId}, the conversation does not exist",
                        message.Id, message.ConversationId);
                    return;
                }
                else if (!validateAction(conversation, message))
                {
                    logger.Information(
                        "Not marking message {Message} as read in conversation {ConversationId}, the validation did not pass",
                        message.Id, message.ConversationId);
                    return;
                }

                var newMember = ConversationMember.ForSeenMessage(message);

                if (ConversationCountersService.ShouldDecrementCounterOnMessageSeen(conversation!, userId, message.Id))
                {
                    transaction.Set(
                        db.Database.UnreadConversationCounter(userId),
                        ConversationCountersSerializer.SerializeConversationCounterDecrement(),
                        SetOptions.MergeAll);
                }

                transaction.Set(doc, ConversationsSerializer.SerializeMemberUpdate(userId, newMember), SetOptions.MergeAll);
            });
        }

        public async Task UpdateUserPresence(Guid userId)
        {
            var doc = db.Database.UserPresence(userId);
            await doc.SetAsync(UserPresenceSerializer.SerializeUserPresence());
        }
    }
}
