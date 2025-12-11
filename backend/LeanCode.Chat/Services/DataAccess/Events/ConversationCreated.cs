using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.DomainModels.Model;
using LeanCode.TimeProvider;

namespace LeanCode.Chat.Services.DataAccess.Events;

public record ConversationCreated : IDomainEvent
{
    public Guid Id { get; private init; }
    public DateTime DateOccurred { get; private init; }

    public Guid ConversationId { get; private init; }
    public List<Guid> ConversationMembers { get; private init; } = null!;
    public IReadOnlyDictionary<string, string> Metadata { get; private init; } = null!;

    public ConversationCreated(Conversation conversation)
    {
        Id = Guid.NewGuid();
        DateOccurred = Time.UtcNow;

        ConversationId = conversation.Id;
        ConversationMembers = conversation.Members.Keys.ToList();
        Metadata = conversation.Metadata;
    }

    [Obsolete("For deserialization only")]
    [JsonConstructor]
    public ConversationCreated(
        Guid id,
        DateTime dateOccurred,
        Guid conversationId,
        List<Guid> conversationMembers,
        IReadOnlyDictionary<string, string> metadata
    )
    {
        Id = id;
        DateOccurred = dateOccurred;
        ConversationId = conversationId;
        ConversationMembers = conversationMembers;
        Metadata = metadata;
    }
}
