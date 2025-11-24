// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoles _$ChatRolesFromJson(Map<String, dynamic> json) => ChatRoles();

Map<String, dynamic> _$ChatRolesToJson(ChatRoles instance) =>
    <String, dynamic>{};

CreateConversation _$CreateConversationFromJson(Map<String, dynamic> json) =>
    CreateConversation(
      conversationId: json['ConversationId'] as String,
      members: (json['Members'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: (json['Metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$CreateConversationToJson(CreateConversation instance) =>
    <String, dynamic>{
      'ConversationId': instance.conversationId,
      'Members': instance.members,
      'Metadata': instance.metadata,
    };

DefaultChatClaims _$DefaultChatClaimsFromJson(Map<String, dynamic> json) =>
    DefaultChatClaims();

Map<String, dynamic> _$DefaultChatClaimsToJson(DefaultChatClaims instance) =>
    <String, dynamic>{};

FirestoreToken _$FirestoreTokenFromJson(Map<String, dynamic> json) =>
    FirestoreToken();

Map<String, dynamic> _$FirestoreTokenToJson(FirestoreToken instance) =>
    <String, dynamic>{};

MarkMessageAsSeen _$MarkMessageAsSeenFromJson(Map<String, dynamic> json) =>
    MarkMessageAsSeen(messageId: json['MessageId'] as String);

Map<String, dynamic> _$MarkMessageAsSeenToJson(MarkMessageAsSeen instance) =>
    <String, dynamic>{'MessageId': instance.messageId};

ChatNotificationContent _$ChatNotificationContentFromJson(
  Map<String, dynamic> json,
) => ChatNotificationContent(
  chatNotificationType: $enumDecode(
    _$ChatNotificationTypeDTOEnumMap,
    json['ChatNotificationType'],
  ),
);

Map<String, dynamic> _$ChatNotificationContentToJson(
  ChatNotificationContent instance,
) => <String, dynamic>{
  'ChatNotificationType':
      _$ChatNotificationTypeDTOEnumMap[instance.chatNotificationType]!,
};

const _$ChatNotificationTypeDTOEnumMap = {
  ChatNotificationTypeDTO.newMessage: 1,
};

NewMessageNotificationContentDTO _$NewMessageNotificationContentDTOFromJson(
  Map<String, dynamic> json,
) => NewMessageNotificationContentDTO(
  chatNotificationType: $enumDecode(
    _$ChatNotificationTypeDTOEnumMap,
    json['ChatNotificationType'],
  ),
  conversationId: json['ConversationId'] as String,
  messageId: json['MessageId'] as String,
);

Map<String, dynamic> _$NewMessageNotificationContentDTOToJson(
  NewMessageNotificationContentDTO instance,
) => <String, dynamic>{
  'ChatNotificationType':
      _$ChatNotificationTypeDTOEnumMap[instance.chatNotificationType]!,
  'ConversationId': instance.conversationId,
  'MessageId': instance.messageId,
};

SendMessage _$SendMessageFromJson(Map<String, dynamic> json) => SendMessage(
  messageId: json['MessageId'] as String,
  conversationId: json['ConversationId'] as String,
  content: json['Content'] as String,
);

Map<String, dynamic> _$SendMessageToJson(SendMessage instance) =>
    <String, dynamic>{
      'MessageId': instance.messageId,
      'ConversationId': instance.conversationId,
      'Content': instance.content,
    };

UpdatePresence _$UpdatePresenceFromJson(Map<String, dynamic> json) =>
    UpdatePresence();

Map<String, dynamic> _$UpdatePresenceToJson(UpdatePresence instance) =>
    <String, dynamic>{};
