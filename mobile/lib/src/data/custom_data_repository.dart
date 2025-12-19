import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/src/chat_custom_data_provider.dart';
import 'package:leancode_chat_client/src/view_models/view_models.dart';

import 'mappers/conversation_mapper.dart';

class CustomDataRepository<TMemberData, TConversationData> {
  CustomDataRepository(this._customDataProvider, this._getCurrentUserId);

  final String? Function() _getCurrentUserId;
  final ChatCustomDataProvider<TMemberData, TConversationData>
  _customDataProvider;

  final Map<String, TMemberData> _membersCache = {};
  final Map<String, TConversationData> _conversationsCache = {};

  Map<String, TMemberData> get allMembers => _membersCache;

  Future<FetchCustomDataResult<TMemberData, TConversationData>> getCustomData(
    List<ConversationRawData> conversations, {
    bool fromCache = true,
  }) async {
    final memberIds = conversations
        .expand((doc) => ConversationMapper.extractMemberIds(doc.data))
        .toSet()
        .toList();

    final conversationIntermediates = conversations
        .map((doc) => ConversationMapper.mapToIntermediate(doc.id, doc.data))
        .toList();

    final membersCacheHit = memberIds.every(_membersCache.containsKey);
    final conversationsCacheHit = conversationIntermediates.every(
      (conversation) => _conversationsCache.containsKey(conversation.id),
    );

    if (!fromCache || !membersCacheHit || !conversationsCacheHit) {
      await _populateCache(memberIds, conversationIntermediates);
    }

    return FetchCustomDataResult(
      {for (final memberId in memberIds) memberId: _membersCache[memberId]},
      {
        for (final conversation in conversationIntermediates)
          conversation.id: _conversationsCache[conversation.id],
      },
    );
  }

  void clearCache() {
    _membersCache.clear();
    _conversationsCache.clear();
  }

  Future<void> _populateCache(
    List<String> memberIds,
    List<ConversationIntermediate> conversations,
  ) async {
    final conversationDataFuture = conversations.isNotEmpty
        ? _customDataProvider.fetchConversationData(conversations)
        : Future.value(<String, TConversationData>{});

    final membersDataFuture = memberIds.isNotEmpty
        ? _customDataProvider.fetchMembersData(memberIds, _getCurrentUserId())
        : Future.value(<String, TMemberData>{});

    await Future.wait([
      conversationDataFuture.then(_conversationsCache.addAll),
      membersDataFuture.then(_membersCache.addAll),
    ]);
  }
}

class FetchCustomDataResult<TMemberData, TConversationData> {
  FetchCustomDataResult(this.members, this.conversations);

  final Map<String, TMemberData?> members;
  final Map<String, TConversationData?> conversations;
}

class ConversationRawData {
  ConversationRawData(this.id, this.data);

  factory ConversationRawData.fromQuerySnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return ConversationRawData(snapshot.id, snapshot.data());
  }

  factory ConversationRawData.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return ConversationRawData(snapshot.id, snapshot.data()!);
  }

  final String id;
  final Map<String, dynamic> data;
}
