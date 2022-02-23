import 'package:cqrs/contracts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contracts.g.dart';

enum ChatNotificationTypeDTO {
@JsonValue(1)
newMessage,
}

@JsonSerializable()
class CreateConversation implements IRemoteCommand {
  const CreateConversation({
    required this.conversationId,
    required this.members,
    this.metadata,
  });

  factory CreateConversation.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationFromJson(json);

  @JsonKey(name: 'ConversationId')
  final String conversationId;
  @JsonKey(name: 'Members')
  final List<String?> members;
  @JsonKey(name: 'Metadata')
  final Map<String, String>? metadata;

  @override
  String getFullName() => 'LeanCode.Chat.Contracts.CreateConversation';

  @override
  Map<String, dynamic> toJson() => _$CreateConversationToJson(this);
}

@JsonSerializable()
class CreateConversationErrorCodes {
  static const noMembers = 1;
  static const cannotCreateConversation = 2;
}

@JsonSerializable()
class FirestoreToken implements IRemoteQuery<String> {
  const FirestoreToken();

  factory FirestoreToken.fromJson(Map<String, dynamic> json) =>
      _$FirestoreTokenFromJson(json);

  @override
  String getFullName() => 'LeanCode.Chat.Contracts.FirestoreToken';

  @override
  String resultFactory(dynamic decodedJson) => decodedJson as String;

  @override
  Map<String, dynamic> toJson() => _$FirestoreTokenToJson(this);
}

@JsonSerializable()
class MarkMessageAsSeen implements IRemoteCommand {
  const MarkMessageAsSeen({required this.messageId});

  factory MarkMessageAsSeen.fromJson(Map<String, dynamic> json) =>
      _$MarkMessageAsSeenFromJson(json);

  @JsonKey(name: 'MessageId')
  final String messageId;

  @override
  String getFullName() => 'LeanCode.Chat.Contracts.MarkMessageAsSeen';

  @override
  Map<String, dynamic> toJson() => _$MarkMessageAsSeenToJson(this);
}

@JsonSerializable()
class MarkMessageAsSeenErrorCodes {
  static const noMessageId = 1;
}

@JsonSerializable()
class SendMessage implements IRemoteCommand {
  const SendMessage({
    required this.messageId,
    required this.conversationId,
    required this.content,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);

  @JsonKey(name: 'MessageId')
  final String messageId;
  @JsonKey(name: 'ConversationId')
  final String conversationId;
  @JsonKey(name: 'Content')
  final String content;

  @override
  String getFullName() => 'LeanCode.Chat.Contracts.SendMessage';

  @override
  Map<String, dynamic> toJson() => _$SendMessageToJson(this);
}

@JsonSerializable()
class SendMessageErrorCodes {
  static const conversationDoesNotExist = 1;
  static const userNotInConversation = 2;
  static const noContent = 3;
  static const noMessageId = 4;
}

@JsonSerializable()
class UpdatePresence implements IRemoteCommand {
  const UpdatePresence();

  factory UpdatePresence.fromJson(Map<String, dynamic> json) =>
      _$UpdatePresenceFromJson(json);

  @override
  String getFullName() => 'LeanCode.Chat.Contracts.UpdatePresence';

  @override
  Map<String, dynamic> toJson() => _$UpdatePresenceToJson(this);
}
