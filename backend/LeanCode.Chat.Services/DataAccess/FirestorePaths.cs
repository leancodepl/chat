using System;
using Google.Cloud.Firestore;

namespace LeanCode.Chat.Services.DataAccess.Entities
{
    public static class FirestorePaths
    {
        public static CollectionReference Messages(this FirestoreDb db) => db.Collection("messages");
        public static DocumentReference Message(this FirestoreDb db, Guid messageId) =>
            db.Messages().Document(messageId.ToString());
        public static CollectionReference Conversations(this FirestoreDb db) => db.Collection("conversations");
        public static DocumentReference Conversation(this FirestoreDb db, Guid conversationId) =>
            db.Conversations().Document(conversationId.ToString());
        public static CollectionReference UnreadConversationCounters(this FirestoreDb db) => db.Collection("unread_conversations_counters");
        public static DocumentReference UnreadConversationCounter(this FirestoreDb db, Guid userId) =>
            db.UnreadConversationCounters().Document(userId.ToString());
        public static CollectionReference UsersPresence(this FirestoreDb db) => db.Collection("users_presence");
        public static DocumentReference UserPresence(this FirestoreDb db, Guid userId) =>
            db.UsersPresence().Document(userId.ToString());
    }
}
