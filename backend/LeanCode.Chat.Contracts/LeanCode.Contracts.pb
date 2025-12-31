
LeanCode.Chat.ContractsB
!LeanCode.Chat.Contracts.ChatRolesR
"
ChatUser"
	chat_userã
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
"	MessageId∏
#LeanCode.Chat.Contracts.SendMessageO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userjø
C
"È
"	MessageId
"ConversationId
"Content

ConversationDoesNotExist

UserNotInConversation

	NoContent

NoMessageId

CannotSendMessageÑ
&LeanCode.Chat.Contracts.UpdatePresenceO
:LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute
"
	chat_userj	

"È"
1