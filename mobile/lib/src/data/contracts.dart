// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
import 'package:leancode_contracts/leancode_contracts.dart';
part 'contracts.g.dart';

@ContractsSerializable()
class ChatRoles with EquatableMixin {
  ChatRoles();

  factory ChatRoles.fromJson(Map<String, dynamic> json) =>
      _$ChatRolesFromJson(json);

  static const String chatUser = 'chat_user';

  static const fullName$ = 'LeanCode.Chat.Contracts.ChatRoles';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$ChatRolesToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('chat_user')
@ContractsSerializable()
class CreateConversation with EquatableMixin implements Command {
  CreateConversation({
    required this.conversationId,
    required this.members,
    required this.metadata,
  });

  factory CreateConversation.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationFromJson(json);

  final String conversationId;

  final List<String> members;

  final Map<String, String>? metadata;

  List<Object?> get props => [conversationId, members, metadata];

  Map<String, dynamic> toJson() => _$CreateConversationToJson(this);

  String getFullName() => 'LeanCode.Chat.Contracts.CreateConversation';
}

class CreateConversationErrorCodes {
  static const noMembers = 1;

  static const cannotCreateConversation = 2;
}

@ContractsSerializable()
class DefaultChatClaims with EquatableMixin {
  DefaultChatClaims();

  factory DefaultChatClaims.fromJson(Map<String, dynamic> json) =>
      _$DefaultChatClaimsFromJson(json);

  static const String userId = 'sub';

  static const String role = 'role';

  static const fullName$ = 'LeanCode.Chat.Contracts.DefaultChatClaims';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$DefaultChatClaimsToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('chat_user')
@ContractsSerializable()
class FirestoreToken with EquatableMixin implements Query<String> {
  FirestoreToken();

  factory FirestoreToken.fromJson(Map<String, dynamic> json) =>
      _$FirestoreTokenFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$FirestoreTokenToJson(this);

  String resultFactory(dynamic decodedJson) => decodedJson as String;

  String getFullName() => 'LeanCode.Chat.Contracts.FirestoreToken';
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('chat_user')
@ContractsSerializable()
class MarkMessageAsSeen with EquatableMixin implements Command {
  MarkMessageAsSeen({required this.messageId});

  factory MarkMessageAsSeen.fromJson(Map<String, dynamic> json) =>
      _$MarkMessageAsSeenFromJson(json);

  final String messageId;

  List<Object?> get props => [messageId];

  Map<String, dynamic> toJson() => _$MarkMessageAsSeenToJson(this);

  String getFullName() => 'LeanCode.Chat.Contracts.MarkMessageAsSeen';
}

class MarkMessageAsSeenErrorCodes {
  static const noMessageId = 1;
}

@ContractsSerializable()
class ChatNotificationContent with EquatableMixin {
  ChatNotificationContent({required this.chatNotificationType});

  factory ChatNotificationContent.fromJson(Map<String, dynamic> json) =>
      _$ChatNotificationContentFromJson(json);

  final ChatNotificationTypeDTO chatNotificationType;

  static const fullName$ =
      'LeanCode.Chat.Contracts.Notifications.ChatNotificationContent';

  List<Object?> get props => [chatNotificationType];

  Map<String, dynamic> toJson() => _$ChatNotificationContentToJson(this);
}

enum ChatNotificationTypeDTO {
  @JsonValue(1)
  newMessage,
}

@ContractsSerializable()
class NewMessageNotificationContentDTO
    with EquatableMixin
    implements ChatNotificationContent {
  NewMessageNotificationContentDTO({
    required this.chatNotificationType,
    required this.conversationId,
    required this.messageId,
  });

  factory NewMessageNotificationContentDTO.fromJson(
    Map<String, dynamic> json,
  ) => _$NewMessageNotificationContentDTOFromJson(json);

  final ChatNotificationTypeDTO chatNotificationType;

  final String conversationId;

  final String messageId;

  static const fullName$ =
      'LeanCode.Chat.Contracts.Notifications.NewMessageNotificationContentDTO';

  List<Object?> get props => [chatNotificationType, conversationId, messageId];

  Map<String, dynamic> toJson() =>
      _$NewMessageNotificationContentDTOToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('chat_user')
@ContractsSerializable()
class SendMessage with EquatableMixin implements Command {
  SendMessage({
    required this.messageId,
    required this.conversationId,
    required this.content,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);

  final String messageId;

  final String conversationId;

  final String content;

  List<Object?> get props => [messageId, conversationId, content];

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);

  String getFullName() => 'LeanCode.Chat.Contracts.SendMessage';
}

class SendMessageErrorCodes {
  static const conversationDoesNotExist = 1;

  static const userNotInConversation = 2;

  static const noContent = 3;

  static const noMessageId = 4;

  static const cannotSendMessage = 5;
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('chat_user')
@ContractsSerializable()
class UpdatePresence with EquatableMixin implements Command {
  UpdatePresence();

  factory UpdatePresence.fromJson(Map<String, dynamic> json) =>
      _$UpdatePresenceFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$UpdatePresenceToJson(this);

  String getFullName() => 'LeanCode.Chat.Contracts.UpdatePresence';
}

class UpdatePresenceErrorCodes {}
