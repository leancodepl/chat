import 'package:freezed_annotation/freezed_annotation.dart';

import 'member_status.dart';
import 'message.dart';

part 'conversation.freezed.dart';

@freezed
abstract class Conversation<TMember, TConversationData>
    with _$Conversation<TMember, TConversationData> {
  const factory Conversation({
    required String id,
    required List<TMember> members,
    required Map<String, MemberStatus> statuses,
    required TConversationData? data,
    required Map<String, String?>? metadata,
    required Message<TMember>? lastMessage,
    required List<String>? lockedByUserIds,
  }) = _Conversation<TMember, TConversationData>;

  const Conversation._();

  bool hasUnreadMessages(String? memberId) {
    final memberStatus = statuses[memberId];
    if (memberStatus == null) {
      return lastMessage != null;
    }
    return memberStatus.lastSeenMessageId != lastMessage?.id;
  }
}

class ConversationIntermediate {
  ConversationIntermediate(this.id, this.metadata);

  final String id;
  final Map<String, String?> metadata;
}
