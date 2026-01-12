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
    final attachmentsData = data['Attachments'] as List<dynamic>?;

    final attachments = attachmentsData?.map((a) {
      final attachmentMap = a as Map<String, dynamic>;
      return Attachment(
        uri: Uri.parse(attachmentMap['Uri'] as String),
        mimeType: attachmentMap['MimeType'] as String,
        fileName: attachmentMap['FileName'] as String,
      );
    }).toList();

    return Message<T>(
      id: id,
      content: data['Content'] as String?,
      attachments: attachments,
      dateSent: (data['DateSent'] as Timestamp).toDate(),
      sender: members[senderId] as T,
      userType: senderId == currentUserId
          ? MessageUserType.sender
          : MessageUserType.receiver,
    );
  }
}
