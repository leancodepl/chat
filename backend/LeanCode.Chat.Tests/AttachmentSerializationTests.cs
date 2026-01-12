using FluentAssertions;
using Google.Cloud.Firestore;
using LeanCode.Chat.Services.DataAccess.Entities;
using LeanCode.Chat.Services.DataAccess.Serializers;
using Xunit;

namespace LeanCode.Chat.Tests;

public class AttachmentSerializationTests
{
    private static readonly Guid TestConversationId = Guid.NewGuid();
    private static readonly Guid TestSenderId = Guid.NewGuid();
    private static readonly Guid TestMessageId = Guid.NewGuid();
    private static readonly DateTime TestDate = DateTime.UtcNow;

    [Fact]
    public void SerializeMessage_correctly_serializes_message_with_attachments()
    {
        // Arrange
        var attachments = new List<Attachment>
        {
            new Attachment(new Uri("https://example.com/file1.jpg"), "image/jpeg", "file1.jpg"),
            new Attachment(new Uri("https://example.com/file2.pdf"), "application/pdf", "file2.pdf"),
        };

        var message = new Message(
            TestMessageId,
            TestConversationId,
            TestSenderId,
            TestDate,
            1,
            "Test message with attachments",
            attachments
        );

        // Act
        var serialized = MessagesSerializer.SerializeMessage(message);
        var serializedType = serialized.GetType();

        // Assert - use reflection to access anonymous type properties
        var attachmentsProp = serializedType.GetProperty("Attachments")!.GetValue(serialized);
        attachmentsProp.Should().NotBeNull();

        var attachmentsList = attachmentsProp as IEnumerable<object>;
        attachmentsList.Should().NotBeNull();
        attachmentsList!.Should().HaveCount(2);

        var firstAttachment = attachmentsList!.First();
        var firstAttachmentType = firstAttachment.GetType();
        firstAttachmentType.GetProperty("Uri")!.GetValue(firstAttachment).Should().Be("https://example.com/file1.jpg");
        firstAttachmentType.GetProperty("MimeType")!.GetValue(firstAttachment).Should().Be("image/jpeg");
        firstAttachmentType.GetProperty("FileName")!.GetValue(firstAttachment).Should().Be("file1.jpg");
    }

    [Fact]
    public void SerializeMessage_correctly_serializes_message_without_attachments()
    {
        // Arrange
        var message = new Message(TestMessageId, TestConversationId, TestSenderId, TestDate, 1, "Test message", null);

        // Act
        var serialized = MessagesSerializer.SerializeMessage(message);
        var serializedType = serialized.GetType();

        // Assert
        var attachmentsProp = serializedType.GetProperty("Attachments")!.GetValue(serialized);
        attachmentsProp.Should().BeNull();
    }

    [Fact]
    public void DeserializeMessage_correctly_deserializes_message_with_attachments()
    {
        // Arrange
        var attachmentsData = new List<object>
        {
            new Dictionary<string, object>
            {
                ["Uri"] = "https://example.com/file1.jpg",
                ["MimeType"] = "image/jpeg",
                ["FileName"] = "file1.jpg",
            },
            new Dictionary<string, object>
            {
                ["Uri"] = "https://example.com/file2.pdf",
                ["MimeType"] = "application/pdf",
                ["FileName"] = "file2.pdf",
            },
        };

        var data = new Dictionary<string, object>
        {
            ["Id"] = TestMessageId.ToString(),
            ["ConversationId"] = TestConversationId.ToString(),
            ["SenderId"] = TestSenderId.ToString(),
            ["DateSent"] = Timestamp.FromDateTime(TestDate),
            ["Content"] = "Test message with attachments",
            ["MessageCounter"] = 1L,
            ["Attachments"] = attachmentsData,
        };

        // Act
        var message = MessagesSerializer.DeserializeMessage(data);

        // Assert
        message.Should().NotBeNull();
        message!.Attachments.Should().NotBeNull();
        message.Attachments.Should().HaveCount(2);

        message.Attachments![0].Uri.ToString().Should().Be("https://example.com/file1.jpg");
        message.Attachments[0].MimeType.Should().Be("image/jpeg");
        message.Attachments[0].FileName.Should().Be("file1.jpg");

        message.Attachments[1].Uri.ToString().Should().Be("https://example.com/file2.pdf");
        message.Attachments[1].MimeType.Should().Be("application/pdf");
        message.Attachments[1].FileName.Should().Be("file2.pdf");
    }

    [Fact]
    public void DeserializeMessage_correctly_deserializes_message_without_attachments()
    {
        // Arrange
        var data = new Dictionary<string, object>
        {
            ["Id"] = TestMessageId.ToString(),
            ["ConversationId"] = TestConversationId.ToString(),
            ["SenderId"] = TestSenderId.ToString(),
            ["DateSent"] = Timestamp.FromDateTime(TestDate),
            ["Content"] = "Test message without attachments",
            ["MessageCounter"] = 1L,
        };

        // Act
        var message = MessagesSerializer.DeserializeMessage(data);

        // Assert
        message.Should().NotBeNull();
        message!.Attachments.Should().BeNull();
        message.Content.Should().Be("Test message without attachments");
    }

    [Fact]
    public void DeserializeMessage_handles_backward_compatibility_for_old_messages()
    {
        // Arrange - old message format without Attachments field
        var data = new Dictionary<string, object>
        {
            ["Id"] = TestMessageId.ToString(),
            ["ConversationId"] = TestConversationId.ToString(),
            ["SenderId"] = TestSenderId.ToString(),
            ["DateSent"] = Timestamp.FromDateTime(TestDate),
            ["Content"] = "Old message format",
            ["MessageCounter"] = 1L,
        };

        // Act
        var message = MessagesSerializer.DeserializeMessage(data);

        // Assert
        message.Should().NotBeNull();
        message!.Attachments.Should().BeNull();
        message.Content.Should().Be("Old message format");
    }
}
