import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:mocktail/mocktail.dart';

import 'fixtures/time.dart';
import 'mocks.dart';

void main() {
  group('UserPresenceCubit', () {
    late UsersPresenceCubit cubit;
    late ChatClient chatClient;

    setUp(() {
      chatClient = MockChatClient();
      when(() => chatClient.presencePolicy)
          .thenReturn(const DefaultUserPresencePolicy());

      cubit = UsersPresenceCubit(chatClient);
    });
    tearDown(() => cubit.close());

    test('has correct initial state', () {
      expect(cubit.state, const UsersPresenceState());
    });

    {
      final userIds = {'a', 'b'};
      final presenceMap1 = {
        'a': UserPresence(fixedNow),
        'b': UserPresence(
          fixedNow.subtract(const Duration(minutes: 5)),
        ),
      };

      final presenceMap2 = {
        'a': UserPresence(
          fixedNow.subtract(const Duration(minutes: 1)),
        ),
        'b': UserPresence(
          fixedNow.subtract(const Duration(minutes: 6)),
        ),
      };

      blocTest<UsersPresenceCubit, UsersPresenceState>(
        'subscribes to users presence',
        build: () {
          when(() => chatClient.subscribeToUsersPresence(userIds)).thenAnswer(
            (_) => Stream.fromIterable([presenceMap1, presenceMap2]),
          );

          return cubit;
        },
        act: (bloc) => withClock(
          fixedClock,
          () => bloc.subscribeToUsersPresence(userIds),
        ),
        expect: () => [
          UsersPresenceState(
            lastSeen: presenceMap1,
            statuses: {
              'a': UserPresenceStatus.online,
              'b': UserPresenceStatus.offline,
            },
          ),
          UsersPresenceState(
            lastSeen: presenceMap2,
            statuses: {
              'a': UserPresenceStatus.offline,
              'b': UserPresenceStatus.offline,
            },
          ),
        ],
      );
    }
  });
}
