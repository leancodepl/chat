using System;
using System.Collections.Generic;
using System.Linq;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.DomainModels.Model;
using LeanCode.IdentityProvider;
using LeanCode.Time;

namespace LeanCode.Chat.Services.DataAccess.Events
{
    public record ConversationCreated : IDomainEvent
    {
        public Guid Id { get; private init; }
        public DateTime DateOccurred { get; private init; }

        public Guid ConversationId { get; private init; }
        public List<Guid> ConversationMembers { get; private init; }
        public IReadOnlyDictionary<string, string> Metadata { get; private init; }

        public ConversationCreated(Conversation conversation)
        {
            Id = Identity.NewId();
            DateOccurred = TimeProvider.Now;

            ConversationId = conversation.Id;
            ConversationMembers = conversation.Members.Keys.ToList();
            Metadata = conversation.Metadata;
        }
    }
}
