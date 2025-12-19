import 'package:leancode_chat_client/leancode_chat_client.dart';

import 'conversation_data.dart';
import 'member.dart';
import 'time.dart';

const conversationCurrentUser = Member(
  id: '42ac603b-a739-4d5c-b511-c4975be31bf4',
  name: 'Grosse Truffle',
);

const conversationOtherMember = Member(
  id: '8543399d-b32c-4dc2-afac-c293acd84816',
  name: 'Grosse Truffle',
);

final chatMembersData = {
  conversationCurrentUser.id: conversationCurrentUser,
  conversationOtherMember.id: conversationOtherMember,
};

const conversationExtraData = '593eaa36-0a09-472b-a12e-f6ce73d6dac3';

const conversation = Conversation<Member, ConversationData>(
  id: 'd7e5f49c-14a5-4d8d-ac84-9c7b803d33df',
  members: [conversationCurrentUser, conversationOtherMember],
  data: null,
  metadata: {'ExtraData': null},
  lastMessage: null,
  statuses: {},
  lockedByUserIds: [],
);

final conversationWithMessage = conversation.copyWith(lastMessage: message0);

const metadataConversation = Conversation<Member, ConversationData>(
  id: 'edb4f687-01fb-4db1-81ff-4f67c888f040',
  members: [conversationCurrentUser, conversationOtherMember],
  data: ConversationData(extraData: 'extra'),
  metadata: {'ExtraData': conversationExtraData},
  lastMessage: null,
  statuses: {},
  lockedByUserIds: [],
);

final metadataConversationWithMessage = metadataConversation.copyWith(
  lastMessage: message1,
);

final message0 = Message(
  id: '67465ad9-9bdc-4e07-934d-4260188234f5',
  content: 'Hi',
  dateSent: fixedNow,
  sender: conversationOtherMember,
  userType: MessageUserType.receiver,
);

final message1 = Message(
  id: 'f3918a5c-e863-4212-ab7c-5fda81a916e1',
  content: 'Hello, how can I help?',
  dateSent: fixedNow,
  sender: conversationCurrentUser,
  userType: MessageUserType.sender,
);
