import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leancode_chat_client/src/data/firestore/firestore_batched_in_query.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  group('FirestoreBatchedInQuery', () {
    late _QueryCallbackMock queryCallback;
    late FirestoreBatchedInQuery<int> batchedQuery;

    setUp(() {
      queryCallback = _QueryCallbackMock();

      final mockQuery = _MockQuery();
      when(mockQuery.snapshots).thenAnswer((_) => const Stream.empty());

      when(() => queryCallback(any())).thenReturn(mockQuery);

      batchedQuery = FirestoreBatchedInQuery(queryCallback);
    });

    test('with single batch', () {
      batchedQuery.run([0, 1, 2]);

      verify(() => queryCallback([0, 1, 2])).called(1);
    });

    test('with multiple batches', () {
      final ids = Iterable<int>.generate(13).toList();

      batchedQuery.run(ids);

      verify(() => queryCallback([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])).called(1);
      verify(() => queryCallback([10, 11, 12])).called(1);
    });
  });
}

abstract class _MockQueryBuilder<T> {
  Query<Map<String, dynamic>> call(List<T> ids);
}

// ignore: deprecated_subtype_of_function
class _QueryCallbackMock extends Mock implements _MockQueryBuilder<int> {
  @override
  Query<Map<String, dynamic>> call(List<int> ids);
}

// ignore: subtype_of_sealed_class
class _MockQuery extends Mock implements Query<Map<String, dynamic>> {}
