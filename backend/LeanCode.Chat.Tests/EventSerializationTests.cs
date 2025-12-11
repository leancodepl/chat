using System.Text.Json;
using FluentAssertions;
using LeanCode.DomainModels.Model;
using Xunit;

namespace LeanCode.Chat.Tests;

public partial class EventSerializationTests
{
    public static IEnumerable<object[]> EventTestData => Events.Select<object, object[]>(e => [e]);

    [Theory]
    [MemberData(nameof(EventTestData))]
    public void Event_correctly_roundtrips_during_STJ_serialization(object @event)
    {
        var type = @event.GetType();
        var serialized = JsonSerializer.Serialize(@event, type, SerializerOptions);
        var deserialized = JsonSerializer.Deserialize(serialized, type, SerializerOptions);

        deserialized
            .Should()
            .BeEquivalentTo(
                expectation: @event,
                config: options =>
                    options
                        .RespectingRuntimeTypes()
                        .Excluding(mi => mi.Type == typeof(JsonElement) || mi.Type == typeof(JsonElement?)), // 😢
                because: "events of type {0} should roundtrip",
                type.FullName
            );
    }

    [Fact]
    public void All_events_are_tested_for_STJ_serialization_roundtrip()
    {
        var verifiedEventTypes = Events.Select(e => e.GetType());
        var allEventTypes = Assemblies
            .SelectMany(a => a.Types())
            .ThatImplement<IDomainEvent>()
            .Where(t => !t.IsAbstract);

        allEventTypes.Should().BeSubsetOf(verifiedEventTypes);
    }
}
