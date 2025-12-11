using System.Collections.Immutable;
using System.Reflection;
using System.Text.Json;
using System.Text.Json.Serialization;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.Chat.Services.DataAccess.Events;

namespace LeanCode.Chat.Tests;

public partial class EventSerializationTests
{
    private static readonly Guid TestConversationId = Guid.Parse("00000000-0000-0000-0000-000000000001");
    private static readonly Guid TestMember1 = Guid.Parse("00000000-0000-0000-0000-000000000002");
    private static readonly Guid TestMember2 = Guid.Parse("00000000-0000-0000-0000-000000000003");

    private static readonly ImmutableArray<object> Events = CreateEvents();

    private static ImmutableArray<object> CreateEvents()
    {
        var metadata = new Dictionary<string, string> { ["key1"] = "value1", ["key2"] = "value2" };

        var conversation = Conversation.Create(TestConversationId, [TestMember1, TestMember2], metadata);
        var conversationCreated = new ConversationCreated(conversation);

        var conversation2 = Conversation.Create(
            Guid.NewGuid(),
            [TestMember1, TestMember2],
            new Dictionary<string, string> { ["key1"] = "value1" }
        );
        var message = conversation2.WriteMessage(Guid.NewGuid(), TestMember1, "Test message content");
        var messageSent = new MessageSent(message, conversation2);

        return [conversationCreated, messageSent];
    }

    private static readonly ImmutableHashSet<Assembly> Assemblies =
    [
        typeof(LeanCode.Chat.Services.DataAccess.ChatService).Assembly,
    ];

    private static readonly JsonSerializerOptions SerializerOptions = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
        Converters = { new JsonStringEnumConverter() },
    };
}
