import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_batched_in_query.dart';
import 'firestore_collections.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore, this._getCurrentUserId);

  final FirebaseFirestore _firestore;
  final String? Function() _getCurrentUserId;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchAllConversations() async {
    final conversations = await _firestore
        .collection(FirestoreCollections.conversations)
        .where('MemberIds', arrayContains: _getCurrentUserId())
        .where('LastMessage.Exists', isEqualTo: true)
        .get();

    return conversations.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchConversationById(
    String conversationId,
  ) async {
    return _firestore
        .collection(FirestoreCollections.conversations)
        .doc(conversationId)
        .get();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?>
      fetchConversationByMetadata({
    required List<String> members,
    required String metadataProperty,
    required String? metadataValue,
  }) async {
    var query = _firestore
        .collection(FirestoreCollections.conversations)
        .where('MemberIds', arrayContains: _getCurrentUserId());

    if (metadataValue == null) {
      query = query.where('Metadata.$metadataProperty', isNull: true);
    } else {
      query =
          query.where('Metadata.$metadataProperty', isEqualTo: metadataValue);
    }

    for (final member in members) {
      query = query.where('Members.$member.Exists', isEqualTo: true);
    }

    final conversations = await query.limit(1).get();
    if (conversations.size == 0) {
      return null;
    }

    return conversations.docs[0];
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchMessages({
    required String conversationId,
    DateTime? startAt,
    required int pageSize,
  }) async {
    var query = _firestore
        .collection(FirestoreCollections.messages)
        .where('ConversationId', isEqualTo: conversationId)
        .orderBy('DateSent', descending: true);

    if (startAt != null) {
      query = query.startAt([startAt]);
    }

    final messagesSnapshot = await query.limit(pageSize).get();
    if (messagesSnapshot.size == 0) {
      return [];
    }

    return messagesSnapshot.docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> subscribeToNewMessages(
    String conversationId, {
    required DateTime after,
  }) {
    return _firestore
        .collection(FirestoreCollections.messages)
        .where('ConversationId', isEqualTo: conversationId)
        .where('DateSent', isGreaterThanOrEqualTo: after)
        .orderBy('DateSent', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> subscribeToConversationUpdates() {
    return _firestore
        .collection(FirestoreCollections.conversations)
        .where('MemberIds', arrayContains: _getCurrentUserId())
        .where('LastMessage.Exists', isEqualTo: true)
        .where('Timestamp', isGreaterThanOrEqualTo: clock.now())
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      subscribeToUnreadConversationsCounter() {
    return _firestore
        .collection(FirestoreCollections.unreadConversationsCounters)
        .doc(_getCurrentUserId())
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> subscribeToUsersPresence(
    List<String> userIds,
  ) {
    final query = FirestoreBatchedInQuery(
      (userIds) => _firestore
          .collection(FirestoreCollections.usersPresence)
          .where(FieldPath.documentId, whereIn: userIds),
    );

    return query.run(userIds);
  }
}
