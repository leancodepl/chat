import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cqrs/cqrs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:leancode_chat_client/src/data/contracts.dart' as c;
import 'package:leancode_chat_client/src/data/custom_data_repository.dart';
import 'package:leancode_chat_client/src/data/firestore/firestore_repository.dart';
import 'package:leancode_chat_client/src/data/mappers/conversation_mapper.dart';
import 'package:leancode_chat_client/src/data/mappers/message_mapper.dart';
import 'package:leancode_chat_client/src/data/mappers/user_presence_mapper.dart';
import 'package:logging/logging.dart';

class ChatClient<TMemberData, TConversationData> {
  ChatClient(
    this._cqrs,
    ChatCustomDataProvider<TMemberData, TConversationData> customDataProvider, {
    this.presencePolicy = const DefaultUserPresencePolicy(),
  }) {
    _firestoreRepository = FirestoreRepository(
      FirebaseFirestore.instance,
      () => currentUserId,
    );
    _customDataRepository =
        CustomDataRepository<TMemberData, TConversationData>(
          customDataProvider,
          () => currentUserId,
        );
  }

  static const defaultPageSize = 25;

  final UserPresencePolicy presencePolicy;
  final Cqrs _cqrs;

  final _logger = Logger('ChatClient');

  late CustomDataRepository<TMemberData, TConversationData>
  _customDataRepository;
  late FirestoreRepository _firestoreRepository;

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> signIn() async {
    try {
      final tokenResult = await _cqrs.get(c.FirestoreToken());
      final String token;
      switch (tokenResult) {
        case QuerySuccess(:final data):
          token = data;
        case QueryFailure():
          return;
      }

      if (FirebaseAuth.instance.currentUser != null) {
        await signOut();
      }

      await FirebaseAuth.instance.signInWithCustomToken(token);

      _logger.info('Successfully logged in to Firebase');
    } catch (e, st) {
      await signOut();
      _logger.warning('failed to log in', e, st);
    }
  }

  Future<void> signOut() async {
    _customDataRepository.clearCache();
    await FirebaseAuth.instance.signOut();

    _logger.info('Signed out from Firebase');
  }

  Future<CommandResult> createConversation({
    required String conversationId,
    required List<String> members,
    required Map<String, String> metadata,
  }) {
    return _cqrs.run(
      c.CreateConversation(
        conversationId: conversationId,
        members: [...members, ?currentUserId],
        metadata: metadata,
      ),
    );
  }

  Future<CommandResult> sendMessage({
    required String messageId,
    required String conversationId,
    required String content,
  }) {
    return _cqrs.run(
      c.SendMessage(
        messageId: messageId,
        conversationId: conversationId,
        content: content,
      ),
    );
  }

  Future<List<Conversation<TMemberData?, TConversationData>>>
  fetchAllConversations() async {
    final snapshots = await _firestoreRepository.fetchAllConversations();
    final customData = await _customDataRepository.getCustomData(
      snapshots.map(ConversationRawData.fromQuerySnapshot).toList(),
      fromCache: false,
    );

    return snapshots
        .map(
          (doc) => ConversationMapper.mapConversation(
            doc.id,
            doc.data(),
            customData.conversations[doc.id],
            customData.members,
            currentUserId,
          ),
        )
        .toList();
  }

  Future<Conversation<TMemberData?, TConversationData>?>
  fetchConversationByMetadata({
    required List<String> members,
    required String metadataProperty,
    required String metadataValue,
  }) async {
    final conversationDocSnapshot = await _firestoreRepository
        .fetchConversationByMetadata(
          members: members,
          metadataProperty: metadataProperty,
          metadataValue: metadataValue,
        );

    if (conversationDocSnapshot == null) {
      return null;
    }

    final customData = await _customDataRepository.getCustomData([
      ConversationRawData.fromQuerySnapshot(conversationDocSnapshot),
    ]);

    return ConversationMapper.mapConversation(
      conversationDocSnapshot.id,
      conversationDocSnapshot.data(),
      customData.conversations[conversationDocSnapshot.id],
      customData.members,
      currentUserId,
    );
  }

  Future<Conversation<TMemberData?, TConversationData>?> fetchConversationById(
    String conversationId,
  ) async {
    final conversationDocSnapshot = await _firestoreRepository
        .fetchConversationById(conversationId);

    if (!conversationDocSnapshot.exists) {
      return null;
    }

    final customData = await _customDataRepository.getCustomData([
      ConversationRawData.fromDocumentSnapshot(conversationDocSnapshot),
    ], fromCache: false);

    return ConversationMapper.mapConversation(
      conversationDocSnapshot.id,
      conversationDocSnapshot.data()!,
      customData.conversations[conversationDocSnapshot.id],
      customData.members,
      currentUserId,
    );
  }

  Future<List<Message<TMemberData?>>> fetchMessages({
    required String conversationId,
    DateTime? searchBefore,
    int pageSize = defaultPageSize,
  }) async {
    final messagesSnapshots = await _firestoreRepository.fetchMessages(
      conversationId: conversationId,
      startAt: searchBefore,
      pageSize: pageSize,
    );

    return messagesSnapshots
        .map(
          (doc) => MessageMapper.mapMessage<TMemberData?>(
            doc.id,
            doc.data(),
            // we assume the conversation must have already been loaded
            // at the moment we're fetching messages
            _customDataRepository.allMembers,
            currentUserId,
          ),
        )
        .toList();
  }

  Stream<List<Message<TMemberData?>>> subscribeToNewMessages(
    Conversation<TMemberData?, TConversationData> conversation,
  ) {
    return _firestoreRepository
        .subscribeToNewMessages(
          conversation.id,
          after: conversation.lastMessage?.dateSent ?? clock.now(),
        )
        .map(
          (event) => event.docChanges
              .map((doc) {
                if (doc.type == DocumentChangeType.added) {
                  return MessageMapper.mapMessage<TMemberData?>(
                    doc.doc.id,
                    doc.doc.data()!,
                    _customDataRepository.allMembers,
                    currentUserId,
                  );
                }
              })
              .whereType<Message<TMemberData?>>()
              .toList(),
        );
  }

  Stream<List<Conversation<TMemberData?, TConversationData>>>
  subscribeToConversationUpdates() {
    return _firestoreRepository.subscribeToConversationUpdates().asyncMap((
      event,
    ) async {
      final customData = await _customDataRepository.getCustomData(
        event.docs.map(ConversationRawData.fromDocumentSnapshot).toList(),
      );

      return event.docs
          .map(
            (doc) => ConversationMapper.mapConversation(
              doc.id,
              doc.data(),
              customData.conversations[doc.id],
              customData.members,
              currentUserId,
            ),
          )
          .toList();
    });
  }

  Future<CommandResult> markMessageAsSeen(String messageId) {
    return _cqrs.run(c.MarkMessageAsSeen(messageId: messageId));
  }

  Stream<int> subscribeToUnreadConversationsCounter() {
    return _firestoreRepository.subscribeToUnreadConversationsCounter().map((
      doc,
    ) {
      final data = doc.data();
      if (data == null) {
        return 0;
      }
      return data['Count'] as int;
    });
  }

  Future<CommandResult> updatePresence() {
    return _cqrs.run(c.UpdatePresence());
  }

  Stream<Map<String, UserPresence>> subscribeToUsersPresence(
    Set<String> userIds,
  ) {
    return _firestoreRepository
        .subscribeToUsersPresence(userIds.toList())
        .map(
          (event) => {
            for (final doc in event.docs)
              doc.id: UserPresenceMapper.mapUserPresence(doc.data()),
          },
        );
  }
}
