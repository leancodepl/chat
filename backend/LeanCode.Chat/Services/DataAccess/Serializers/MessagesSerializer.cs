using System;
using System.Collections.Generic;
using System.Linq;
using Google.Cloud.Firestore;
using LeanCode.Chat.Services.DataAccess.Entities;

namespace LeanCode.Chat.Services.DataAccess.Serializers;

internal static class MessagesSerializer
{
    public static object SerializeMessage(Message m)
    {
        return new
        {
            SenderId = m.SenderId.ToString(),
            ConversationId = m.ConversationId.ToString(),
            m.MessageCounter,

            m.DateSent,
            m.Content,
            Attachments = m
                .Attachments?.Select(a => new
                {
                    Uri = a.Uri.ToString(),
                    a.MimeType,
                    a.FileName,
                })
                .ToList(),
        };
    }

    public static Message? DeserializeMessage(DocumentSnapshot doc)
    {
        if (!doc.Exists)
        {
            return null;
        }

        var id = Guid.Parse(doc.Id);
        var conversationId = Guid.Parse(doc.GetValue<string>(nameof(Message.ConversationId)));
        var senderId = Guid.Parse(doc.GetValue<string>(nameof(Message.SenderId)));
        var dateSent = doc.GetValue<DateTime>(nameof(Message.DateSent));
        doc.TryGetValue<string?>(nameof(Message.Content), out var content);
        doc.TryGetValue<long?>(nameof(Message.MessageCounter), out var msgCounter);
        doc.TryGetValue<List<Dictionary<string, object>>?>(nameof(Message.Attachments), out var attachmentsData);

        var attachments = attachmentsData
            ?.Select(a => new Attachment(
                new Uri((string)a[nameof(Attachment.Uri)]),
                (string)a[nameof(Attachment.MimeType)],
                (string)a[nameof(Attachment.FileName)]
            ))
            .ToList();

        return new Message(
            id,
            conversationId,
            senderId,
            dateSent,
            msgCounter ?? Message.UnavailableCounterValue,
            content,
            attachments
        );
    }

    public static Message? DeserializeMessage(Dictionary<string, object> map)
    {
        var id = Guid.Parse((map?[nameof(Message.Id)] as string)!);
        var conversationId = Guid.Parse((map?[nameof(Message.ConversationId)] as string)!);
        var senderId = Guid.Parse((map?[nameof(Message.SenderId)] as string)!);
        var dateSent = ((Timestamp)map?[nameof(Message.DateSent)]!).ToDateTime();
        var content = map?[nameof(Message.Content)] as string;
        var msgCounter = GetMessageCounter(map);

        var attachmentsData =
            map?.TryGetValue(nameof(Message.Attachments), out var attachmentsObj) == true
                ? attachmentsObj as List<object>
                : null;

        var attachments = attachmentsData
            ?.Select(a =>
            {
                var dict = (Dictionary<string, object>)a;
                return new Attachment(
                    new Uri((string)dict[nameof(Attachment.Uri)]),
                    (string)dict[nameof(Attachment.MimeType)],
                    (string)dict[nameof(Attachment.FileName)]
                );
            })
            .ToList();

        return new Message(id, conversationId, senderId, dateSent, msgCounter, content, attachments);
    }

    private static long GetMessageCounter(Dictionary<string, object>? map)
    {
        if (map is not null)
        {
            map.TryGetValue(nameof(Message.MessageCounter), out var lastSeenMessageCounter);
            return lastSeenMessageCounter is long v ? v : Message.UnavailableCounterValue;
        }
        else
        {
            return Message.UnavailableCounterValue;
        }
    }
}
