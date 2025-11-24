import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageUserType { sender, receiver }

@freezed
abstract class Message<TChatMember> with _$Message<TChatMember> {
  const factory Message({
    required String id,
    required String content,
    required DateTime dateSent,
    required TChatMember sender,
    required MessageUserType userType,
  }) = _Message<TChatMember>;
}
