using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.DomainModels.Model;
using LeanCode.TimeProvider;

namespace LeanCode.Chat.Services.DataAccess.Events;

public record MessageSent : IDomainEvent
{
    public Guid Id { get; private init; }
    public DateTime DateOccurred { get; private init; }

    public Guid MessageId { get; private init; }
    public Guid ConversationId { get; private init; }
    public Guid SenderId { get; private init; }
    public List<Guid> ConversationMembers { get; private init; } = null!;
    public string Content { get; private init; } = null!;
    public Dictionary<string, string> ConversationMetadata { get; private init; } = null!;

    private MessageSent() { }

    public MessageSent(Message m, Conversation c)
    {
        Id = Guid.NewGuid();
        DateOccurred = Time.UtcNow;

        MessageId = m.Id;
        ConversationId = c.Id;
        SenderId = m.SenderId;
        ConversationMembers = c.Members.Keys.ToList();
        Content = m.Content;
        ConversationMetadata = c.Metadata.ToDictionary(e => e.Key, e => e.Value);
    }

    [Obsolete("For deserialization only")]
    [JsonConstructor]
    public MessageSent(
        Guid id,
        DateTime dateOccurred,
        Guid messageId,
        Guid conversationId,
        Guid senderId,
        List<Guid> conversationMembers,
        string content,
        Dictionary<string, string> conversationMetadata
    )
    {
        Id = id;
        DateOccurred = dateOccurred;
        MessageId = messageId;
        ConversationId = conversationId;
        SenderId = senderId;
        ConversationMembers = conversationMembers;
        Content = content;
        ConversationMetadata = conversationMetadata;
    }
}
