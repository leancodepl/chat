using System;
using System.Collections.Generic;
using System.Linq;
using LeanCode.Chat.Services.DataAccess.Entities;

namespace LeanCode.Chat.Services.DataAccess.Services
{
    public class ConversationCountersService
    {
        public static IEnumerable<Guid> GetMemberIdsForIncrementOnNewMessage(
            Conversation conversation,
            Message newMessage
        )
        {
            return conversation
                .Members.Where(m => !conversation.HasUnreadMessages(m.Key) && m.Key != newMessage.SenderId)
                .Select(m => m.Key);
        }

        public static IEnumerable<Guid> GetMemberIdsForDecrementOnNewMessage(
            Conversation conversation,
            Message newMessage
        )
        {
            if (conversation.HasUnreadMessages(newMessage.SenderId))
            {
                yield return newMessage.SenderId;
            }
        }

        public static bool ShouldDecrementCounterOnMessageSeen(
            Conversation conversation,
            Guid userId,
            Guid seenMessageId
        )
        {
            return conversation.HasUnreadMessages(userId) && seenMessageId == conversation.LastMessage?.Id;
        }
    }
}
