import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:leancode_chat_client/src/data/mappers/message_mapper.dart';
import 'package:test/test.dart';

import 'fixtures/conversations.dart';
import 'fixtures/time.dart';

void main() {
  group('MessageMapper', () {
    const messageId = '3927c63a-ea54-4d46-9284-440754eda342';

    test('correctly maps sent message', () {
      final data = {
        'DateSent': Timestamp.fromDate(fixedNow),
        'Content': 'Hello',
        'SenderId': conversationCurrentUser.id,
        'ConversationId': 'cb034fde-28da-45fc-870e-8a188e6a340d',
      };

      final message = MessageMapper.mapMessage(messageId, data, {
        conversationCurrentUser.id: conversationCurrentUser,
      }, conversationCurrentUser.id);

      expect(
        message,
        equals(
          Message(
            id: messageId,
            dateSent: fixedNow,
            content: 'Hello',
            sender: conversationCurrentUser,
            userType: MessageUserType.sender,
          ),
        ),
      );
    });

    test('correctly maps received message', () {
      final data = {
        'DateSent': Timestamp.fromDate(fixedNow),
        'Content': 'Hello',
        'SenderId': conversationOtherMember.id,
        'ConversationId': 'cb034fde-28da-45fc-870e-8a188e6a340d',
      };

      final message = MessageMapper.mapMessage(messageId, data, {
        conversationOtherMember.id: conversationOtherMember,
      }, conversationCurrentUser.id);

      expect(
        message,
        equals(
          Message(
            id: messageId,
            dateSent: fixedNow,
            content: 'Hello',
            sender: conversationOtherMember,
            userType: MessageUserType.receiver,
          ),
        ),
      );
    });

    test('correctly maps message with attachments', () {
      final data = {
        'DateSent': Timestamp.fromDate(fixedNow),
        'Content': 'Check this out',
        'SenderId': conversationCurrentUser.id,
        'ConversationId': 'cb034fde-28da-45fc-870e-8a188e6a340d',
        'Attachments': [
          {
            'Uri': 'https://example.com/file1.jpg',
            'MimeType': 'image/jpeg',
            'FileName': 'file1.jpg',
          },
          {
            'Uri': 'https://example.com/file2.pdf',
            'MimeType': 'application/pdf',
            'FileName': 'file2.pdf',
          },
        ],
      };

      final message = MessageMapper.mapMessage(messageId, data, {
        conversationCurrentUser.id: conversationCurrentUser,
      }, conversationCurrentUser.id);

      expect(
        message,
        equals(
          Message(
            id: messageId,
            dateSent: fixedNow,
            content: 'Check this out',
            attachments: [
              Attachment(
                uri: Uri.parse('https://example.com/file1.jpg'),
                mimeType: 'image/jpeg',
                fileName: 'file1.jpg',
              ),
              Attachment(
                uri: Uri.parse('https://example.com/file2.pdf'),
                mimeType: 'application/pdf',
                fileName: 'file2.pdf',
              ),
            ],
            sender: conversationCurrentUser,
            userType: MessageUserType.sender,
          ),
        ),
      );
    });

    test('correctly maps message without content (only attachments)', () {
      final data = {
        'DateSent': Timestamp.fromDate(fixedNow),
        'SenderId': conversationCurrentUser.id,
        'ConversationId': 'cb034fde-28da-45fc-870e-8a188e6a340d',
        'Attachments': [
          {
            'Uri': 'https://example.com/image.png',
            'MimeType': 'image/png',
            'FileName': 'image.png',
          },
        ],
      };

      final message = MessageMapper.mapMessage(messageId, data, {
        conversationCurrentUser.id: conversationCurrentUser,
      }, conversationCurrentUser.id);

      expect(
        message,
        equals(
          Message(
            id: messageId,
            dateSent: fixedNow,
            attachments: [
              Attachment(
                uri: Uri.parse('https://example.com/image.png'),
                mimeType: 'image/png',
                fileName: 'image.png',
              ),
            ],
            sender: conversationCurrentUser,
            userType: MessageUserType.sender,
          ),
        ),
      );
    });

    test(
      'correctly maps message without attachments (backward compatibility)',
      () {
        final data = {
          'DateSent': Timestamp.fromDate(fixedNow),
          'Content': 'Old message format',
          'SenderId': conversationCurrentUser.id,
          'ConversationId': 'cb034fde-28da-45fc-870e-8a188e6a340d',
        };

        final message = MessageMapper.mapMessage(messageId, data, {
          conversationCurrentUser.id: conversationCurrentUser,
        }, conversationCurrentUser.id);

        expect(
          message,
          equals(
            Message(
              id: messageId,
              dateSent: fixedNow,
              content: 'Old message format',
              sender: conversationCurrentUser,
              userType: MessageUserType.sender,
            ),
          ),
        );
      },
    );
  });
}
