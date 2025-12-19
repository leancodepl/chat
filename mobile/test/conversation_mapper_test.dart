import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:leancode_chat_client/src/data/mappers/conversation_mapper.dart';
import 'package:test/test.dart';

import 'fixtures/conversations.dart';
import 'fixtures/time.dart';

void main() {
  group('ConversationMapper', () {
    const conversationId = '3927c63a-ea54-4d46-9284-440754eda342';
    const emptyGuid = '00000000-0000-0000-0000-000000000000';

    final emptyMemberStatus = {
      'Exists': true,
      'LastDeliveredMessageDate': Timestamp.fromDate(fixedNow),
      'LastDeliveredMessageId': emptyGuid,
      'LastSeenMessageDate': Timestamp.fromDate(fixedNow),
      'LastSeenMessageId': emptyGuid,
    };

    test(
      'correctly maps conversation without last message and auction data',
      () {
        final data = {
          'LastMessage': {'Exists': true},
          'MemberIds': [conversationCurrentUser.id, conversationOtherMember.id],
          'Members': {
            conversationCurrentUser.id: emptyMemberStatus,
            conversationOtherMember.id: emptyMemberStatus,
          },
          'Metadata': {'ExtraData': null},
          'Timestamp': Timestamp.fromDate(fixedNow),
          'LockedByUserIds': <String>[],
        };

        final conversation = ConversationMapper.mapConversation(
          conversationId,
          data,
          null,
          chatMembersData,
          conversationCurrentUser.id,
        );

        expect(
          conversation,
          equals(
            Conversation(
              id: conversationId,
              metadata: {'ExtraData': null},
              data: null,
              lastMessage: null,
              members: [conversationCurrentUser, conversationOtherMember],
              statuses: {
                conversationCurrentUser.id: MemberStatus(
                  lastSeenMessageDate: fixedNow,
                  lastSeenMessageId: emptyGuid,
                ),
                conversationOtherMember.id: MemberStatus(
                  lastSeenMessageDate: fixedNow,
                  lastSeenMessageId: emptyGuid,
                ),
              },
              lockedByUserIds: [],
            ),
          ),
        );
      },
    );

    test('correctly maps conversation with auction data', () {
      final data = {
        'LastMessage': {'Exists': true},
        'MemberIds': [conversationCurrentUser.id, conversationOtherMember.id],
        'Members': {
          conversationCurrentUser.id: emptyMemberStatus,
          conversationOtherMember.id: emptyMemberStatus,
        },
        'Metadata': {'ExtraData': conversationExtraData},
        'Timestamp': Timestamp.fromDate(fixedNow),
        'LockedByUserIds': [conversationOtherMember.id],
      };

      final conversation = ConversationMapper.mapConversation(
        conversationId,
        data,
        metadataConversation.data,
        chatMembersData,
        conversationCurrentUser.id,
      );

      expect(
        conversation,
        equals(
          Conversation(
            id: conversationId,
            metadata: {'ExtraData': conversationExtraData},
            data: metadataConversation.data,
            lastMessage: null,
            members: [conversationCurrentUser, conversationOtherMember],
            statuses: {
              conversationCurrentUser.id: MemberStatus(
                lastSeenMessageDate: fixedNow,
                lastSeenMessageId: emptyGuid,
              ),
              conversationOtherMember.id: MemberStatus(
                lastSeenMessageDate: fixedNow,
                lastSeenMessageId: emptyGuid,
              ),
            },
            lockedByUserIds: [conversationOtherMember.id],
          ),
        ),
      );
    });

    test('correctly maps conversation with last message', () {
      const messageId = '21595ad9-9bdc-4e07-934d-4260188234f5';

      final data = {
        'LastMessage': {
          'Exists': true,
          'Id': messageId,
          'Content': 'Hello',
          'ConversationId': conversationId,
          'DateSent': Timestamp.fromDate(fixedNow),
          'SenderId': conversationOtherMember.id,
        },
        'MemberIds': [conversationCurrentUser.id, conversationOtherMember.id],
        'Members': {
          conversationCurrentUser.id: {
            ...emptyMemberStatus,
            'LastSeenMessageId': messageId,
          },
          conversationOtherMember.id: {
            ...emptyMemberStatus,
            'LastSeenMessageId': messageId,
          },
        },
        'Metadata': {'ExtraData': null},
        'Timestamp': Timestamp.fromDate(fixedNow),
        'LockedByUserIds': [conversationOtherMember.id],
      };

      final conversation = ConversationMapper.mapConversation(
        conversationId,
        data,
        null,
        chatMembersData,
        conversationCurrentUser.id,
      );

      expect(
        conversation,
        equals(
          Conversation(
            id: conversationId,
            metadata: {'ExtraData': null},
            data: null,
            lastMessage: Message(
              id: messageId,
              content: 'Hello',
              dateSent: fixedNow,
              sender: conversationOtherMember,
              userType: MessageUserType.receiver,
            ),
            members: [conversationCurrentUser, conversationOtherMember],
            statuses: {
              conversationCurrentUser.id: MemberStatus(
                lastSeenMessageDate: fixedNow,
                lastSeenMessageId: messageId,
              ),
              conversationOtherMember.id: MemberStatus(
                lastSeenMessageDate: fixedNow,
                lastSeenMessageId: messageId,
              ),
            },
            lockedByUserIds: [conversationOtherMember.id],
          ),
        ),
      );
    });
  });
}
