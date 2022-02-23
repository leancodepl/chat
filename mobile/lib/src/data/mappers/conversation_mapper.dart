// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/src/view_models/view_models.dart';

import 'message_mapper.dart';

abstract class ConversationMapper {
  static Conversation<TMember, TConversationData>
      mapConversation<TMember, TConversationData>(
    String id,
    Map<String, dynamic> data,
    TConversationData? customData,
    Map<String, TMember> members,
    String? currentUserId,
  ) {
    return Conversation<TMember, TConversationData>(
      id: id,
      data: customData,
      metadata: _mapMetadata(data),
      members: (data['MemberIds'] as List<dynamic>)
          .map((dynamic id) => members[id as String])
          .cast<TMember>()
          .toList(),
      lastMessage: data['LastMessage']['Id'] != null
          ? MessageMapper.mapMessage(
              data['LastMessage']['Id'] as String,
              data['LastMessage'] as Map<String, dynamic>,
              members,
              currentUserId,
            )
          : null,
      statuses: _mapMemberStatuses(
        data['Members'] as Map<String, dynamic>,
      ),
      lockedByUserIds:
          (data['LockedByUserIds'] as List<dynamic>? ?? <dynamic>[])
              .map((dynamic id) => id as String)
              .toList(),
    );
  }

  static ConversationIntermediate mapToIntermediate(
    String id,
    Map<String, dynamic> data,
  ) {
    return ConversationIntermediate(id, _mapMetadata(data));
  }

  static List<String> extractMemberIds(Map<String, dynamic> data) {
    return (data['MemberIds'] as List<dynamic>)
        .map((dynamic id) => id as String)
        .toList();
  }

  static Map<String, String?> _mapMetadata(Map<String, dynamic> data) {
    final rawMetadata = data['Metadata'] as Map<String, dynamic>;
    return {
      for (final key in rawMetadata.keys) key: rawMetadata[key] as String?,
    };
  }

  static Map<String, MemberStatus> _mapMemberStatuses(
    Map<String, dynamic> data,
  ) {
    return {
      for (final entry in data.entries)
        entry.key: MemberStatus(
          lastSeenMessageId: entry.value['LastSeenMessageId'] as String,
          lastSeenMessageDate:
              (entry.value['LastSeenMessageDate'] as Timestamp).toDate(),
        ),
    };
  }
}
