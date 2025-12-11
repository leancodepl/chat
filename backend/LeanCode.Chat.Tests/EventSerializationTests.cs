using System.Text.Json;
using System.Text.Json.Serialization;
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

    [Fact]
    public void All_ctors_set_every_property()
    {
        var allEventTypes = Assemblies
            .SelectMany(a => a.Types())
            .ThatImplement<IDomainEvent>()
            .Where(t => !t.IsAbstract);

        foreach (var type in allEventTypes)
        {
            var ctor = type.GetConstructors()
                .Single(t => t.CustomAttributes.Any(a => a.AttributeType == typeof(JsonConstructorAttribute)));
            var properties = type.GetProperties();
            ctor.GetParameters()
                .Select(p => p.Name?.ToLower())
                .Should()
                .BeEquivalentTo(
                    properties.Select(p => p.Name.ToLower()),
                    "ctor {0} should set all properties",
                    type.FullName
                );
        }
    }
}
