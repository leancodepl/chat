import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/src/view_models/view_models.dart';

abstract class MessageMapper {
  static Message<T> mapMessage<T>(
    String id,
    Map<String, dynamic> data,
    Map<String, T> members,
    String? currentUserId,
  ) {
    final senderId = data['SenderId'] as String;

    return Message<T>(
      id: id,
      content: data['Content'] as String,
      dateSent: (data['DateSent'] as Timestamp).toDate(),
      sender: members[senderId] as T,
      userType: senderId == currentUserId
          ? MessageUserType.sender
          : MessageUserType.receiver,
    );
  }
}
