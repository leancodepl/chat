import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

typedef QueryBuilder<T> = Query<Map<String, dynamic>> Function(List<T>);

class FirestoreBatchedInQuery<T> {
  FirestoreBatchedInQuery(this._queryBuilder);

  // Firestore limit for IN queries
  // https://cloud.google.com/firestore/docs/query-data/queries#query_limitations
  static const maxBatchSize = 10;

  // Type parameter in function parameter position is contravariant, which is expected for this builder pattern
  // ignore: unsafe_variance
  final QueryBuilder<T> _queryBuilder;

  Stream<QuerySnapshot<Map<String, dynamic>>> run(List<T> params) {
    final batchesCount = params.length / 10;

    final streams = <Stream<QuerySnapshot<Map<String, dynamic>>>>[];

    for (var i = 0; i < batchesCount; i++) {
      final batchStart = maxBatchSize * i;
      final batchEnd = min(maxBatchSize * (i + 1), params.length);

      final batch = params.sublist(batchStart, batchEnd);

      final query = _queryBuilder(batch);
      final stream = query.snapshots();
      streams.add(stream);
    }

    return Rx.merge(streams);
  }
}
