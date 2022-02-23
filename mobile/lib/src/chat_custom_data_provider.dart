import 'package:leancode_chat_client/src/view_models/view_models.dart';

abstract class ChatCustomDataProvider<TMemberData, TConversationData> {
  Future<Map<String, TMemberData>> fetchMembersData(
    List<String> userIds,
    String? currentUserId,
  );

  Future<Map<String, TConversationData>> fetchConversationData(
    List<ConversationIntermediate> conversations,
  );
}
