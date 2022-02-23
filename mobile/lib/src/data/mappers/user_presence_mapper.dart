import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';

abstract class UserPresenceMapper {
  static UserPresence mapUserPresence(Map<String, dynamic> data) {
    final lastSeen = (data['LastSeen'] as Timestamp).toDate();
    return UserPresence(lastSeen);
  }
}
