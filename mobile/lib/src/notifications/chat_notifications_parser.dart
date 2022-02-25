import 'package:leancode_chat_client/src/data/contracts.dart' as c;

abstract class ChatNotificationsParser {
  /// Checks whether a push notification with the JSON `payload`
  /// is related to the chat
  static bool isChatNotification(Map<String, dynamic> payload) {
    final dynamic typeString = payload['ChatNotificationType'];
    if (typeString is! String) {
      return false;
    }

    final type = int.parse(typeString);
    return type > 0 && type <= c.ChatNotificationTypeDTO.values.length;
  }

  static String? extractConversationId(Map<String, dynamic> payload) {
    final dynamic id = payload['ConversationId'];

    return id is! String ? null : id;
  }
}
