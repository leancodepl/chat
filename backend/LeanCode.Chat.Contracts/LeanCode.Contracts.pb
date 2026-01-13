
LeanCode.Chat.Contracts\
%LeanCode.Chat.Contracts.AttachmentDTOR3
1
"Uri
"MimeType
"FileName‰
+LeanCode.Chat.Contracts.AttachmentUploadUrlO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userbd
\
"	Ë"
"ConversationId
"	MessageId
"FileName
"MimeType"B
!LeanCode.Chat.Contracts.ChatRolesR
"
ChatUser"
	chat_user•
4LeanCode.Chat.Contracts.ConversationAttachmentsTokenO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userbõ
\
B"@Ë;9
7LeanCode.Chat.Contracts.ConversationAttachmentsTokenDTO
"ConversationId;9
7LeanCode.Chat.Contracts.ConversationAttachmentsTokenDTOc
7LeanCode.Chat.Contracts.ConversationAttachmentsTokenDTOR(
&
"SasToken
" 	ExpiresAtã
*LeanCode.Chat.Contracts.CreateConversationO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userjã
X
"È
"ConversationId
"	¨"Members
"≠""Metadata

	NoMembers

CannotCreateConversationT
)LeanCode.Chat.Contracts.DefaultChatClaimsR'
%"
UserId"
sub"
Role"
roleê
&LeanCode.Chat.Contracts.FirestoreTokenO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userb

"	Ë""≠
)LeanCode.Chat.Contracts.MarkMessageAsSeenO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userj/

"È
"	MessageId

NoMessageIdû
=LeanCode.Chat.Contracts.Notifications.ChatNotificationContentR]
[Y
A?
=LeanCode.Chat.Contracts.Notifications.ChatNotificationTypeDTOChatNotificationTypeQ
=LeanCode.Chat.Contracts.Notifications.ChatNotificationTypeDTOZ


NewMessageó
FLeanCode.Chat.Contracts.Notifications.NewMessageNotificationContentDTORÃ
…
A?
=LeanCode.Chat.Contracts.Notifications.ChatNotificationContentY
A?
=LeanCode.Chat.Contracts.Notifications.ChatNotificationTypeDTOChatNotificationType
"ConversationId
"	MessageId¿
#LeanCode.Chat.Contracts.SendMessageO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userj«
à
"È
"	MessageId
"ConversationId
"ContentA
2".¨)'
%LeanCode.Chat.Contracts.AttachmentDTOAttachments

ConversationDoesNotExist

UserNotInConversation

	NoContent

NoMessageId

CannotSendMessage'
%
!OneOfContentOrAttachmentsRequired

InvalidAttachmentÑ
&LeanCode.Chat.Contracts.UpdatePresenceO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userj	

"È"
1