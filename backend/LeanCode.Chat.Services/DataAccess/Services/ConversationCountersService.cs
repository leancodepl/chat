using System;
using System.Collections.Generic;
using System.Linq;
using LeanCode.Chat.Services.DataAccess.Entities;

namespace LeanCode.Chat.Services.DataAccess.Services
{
    public class ConversationCountersService
    {
        public static IEnumerable<Guid> GetMemberIdsForIncrementOnNewMessage(Conversation conversation)
        {
            return conversation.Members.Keys.Where(m => !conversation.HasUnreadMessages(m));
        }

        public static bool ShouldDecrementCounterOnMessageSeen(Conversation conversation, Guid userId, Guid seenMessageId)
        {
            return conversation.HasUnreadMessages(userId) && seenMessageId == conversation.LastMessage?.Id;
        }
    }
}
