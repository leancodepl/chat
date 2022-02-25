// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateConversation _$CreateConversationFromJson(Map<String, dynamic> json) =>
    CreateConversation(
      conversationId: json['ConversationId'] as String,
      members:
      (json['Members'] as List<dynamic>).map((e) => e as String?).toList(),
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

CreateConversationErrorCodes _$CreateConversationErrorCodesFromJson(
    Map<String, dynamic> json) =>
    CreateConversationErrorCodes();

Map<String, dynamic> _$CreateConversationErrorCodesToJson(
    CreateConversationErrorCodes instance) =>
    <String, dynamic>{};

FirestoreToken _$FirestoreTokenFromJson(Map<String, dynamic> json) =>
    FirestoreToken();

Map<String, dynamic> _$FirestoreTokenToJson(FirestoreToken instance) =>
    <String, dynamic>{};

MarkMessageAsSeen _$MarkMessageAsSeenFromJson(Map<String, dynamic> json) =>
    MarkMessageAsSeen(
      messageId: json['MessageId'] as String,
    );

Map<String, dynamic> _$MarkMessageAsSeenToJson(MarkMessageAsSeen instance) =>
    <String, dynamic>{
      'MessageId': instance.messageId,
    };

MarkMessageAsSeenErrorCodes _$MarkMessageAsSeenErrorCodesFromJson(
    Map<String, dynamic> json) =>
    MarkMessageAsSeenErrorCodes();

Map<String, dynamic> _$MarkMessageAsSeenErrorCodesToJson(
    MarkMessageAsSeenErrorCodes instance) =>
    <String, dynamic>{};

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

SendMessageErrorCodes _$SendMessageErrorCodesFromJson(
    Map<String, dynamic> json) =>
    SendMessageErrorCodes();

Map<String, dynamic> _$SendMessageErrorCodesToJson(
    SendMessageErrorCodes instance) =>
    <String, dynamic>{};

UpdatePresence _$UpdatePresenceFromJson(Map<String, dynamic> json) =>
    UpdatePresence();

Map<String, dynamic> _$UpdatePresenceToJson(UpdatePresence instance) =>
    <String, dynamic>{};
