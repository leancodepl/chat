import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  group('UnreadConversationsCounterCubit', () {
    late UnreadConversationsCounterCubit cubit;
    late ChatClient<dynamic, dynamic> chatClient;

    setUp(() {
      chatClient = MockChatClient();

      cubit = UnreadConversationsCounterCubit(chatClient);
    });
    tearDown(() => cubit.close());

    test('has correct initial state', () {
      expect(cubit.state, 0);
    });

    blocTest<UnreadConversationsCounterCubit, int>(
      'updates counter',
      build: () {
        when(
          () => chatClient.subscribeToUnreadConversationsCounter(),
        ).thenAnswer((_) => Stream.fromIterable([2, 3]));

        return cubit;
      },
      act: (bloc) => bloc.start(),
      expect: () => [2, 3],
    );
  });
}
