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
  });
}
