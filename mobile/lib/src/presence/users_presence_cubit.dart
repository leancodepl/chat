import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';
import 'package:logging/logging.dart';

part 'users_presence_cubit.freezed.dart';

class UsersPresenceCubit extends Cubit<UsersPresenceState> {
  UsersPresenceCubit(this._chatClient) : super(const UsersPresenceState());

  final ChatClient _chatClient;
  final Set<String> _subscribedUsers = {};
  final List<StreamSubscription> _subscriptions = [];

  Timer? _timer;
  final _logger = Logger('UsersPresenceCubit');

  /// Starts tracking presence of users with ids passed in `userIds`.
  ///
  /// If some of the users are already tracked, they are omitted.
  void subscribeToUsersPresence(Set<String> userIds) {
    final usersToSubscribe = userIds.difference(_subscribedUsers);
    final subscription = _chatClient
        .subscribeToUsersPresence(usersToSubscribe)
        .listen(_updateState);

    _subscriptions.add(subscription);

    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        _chatClient.presencePolicy.statusRefreshInterval,
        _onTick,
      );
    }
  }

  Future<void> unsubscribeFromAll() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }

    _subscribedUsers.clear();
    _subscriptions.clear();
    _timer?.cancel();

    _logger.info('Stopped monitoring users presence');
  }

  @override
  Future<void> close() async {
    await unsubscribeFromAll();
    await super.close();
  }

  void _onTick(Timer timer) {
    emit(state.copyWith(statuses: _refreshStatuses(state.lastSeen)));
  }

  void _updateState(Map<String, UserPresence> newLastSeen) {
    final allLastSeen = {...state.lastSeen, ...newLastSeen};

    emit(
      state.copyWith(
        lastSeen: allLastSeen,
        statuses: _refreshStatuses(allLastSeen),
      ),
    );
  }

  Map<String, UserPresenceStatus> _refreshStatuses(
    Map<String, UserPresence> lastSeen,
  ) {
    return {
      for (final entry in lastSeen.entries)
        entry.key: entry.value.getStatus(_chatClient.presencePolicy),
    };
  }
}

@freezed
abstract class UsersPresenceState with _$UsersPresenceState {
  const factory UsersPresenceState({
    @Default(<String, UserPresence>{}) Map<String, UserPresence> lastSeen,
    @Default(<String, UserPresenceStatus>{})
    Map<String, UserPresenceStatus> statuses,
  }) = _UsersPresenceState;

  const UsersPresenceState._();

  bool isOnline(String userId) => statuses[userId] == UserPresenceStatus.online;
}
