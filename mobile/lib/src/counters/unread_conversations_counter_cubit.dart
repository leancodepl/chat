import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_chat_client/leancode_chat_client.dart';

class UnreadConversationsCounterCubit extends Cubit<int> {
  UnreadConversationsCounterCubit(this._chatClient) : super(0);

  final ChatClient _chatClient;

  StreamSubscription? _subscription;

  void start() {
    _subscription =
        _chatClient.subscribeToUnreadConversationsCounter().listen(emit);
  }

  Future<void> stop() async {
    await _subscription?.cancel();
  }

  @override
  Future<void> close() async {
    await stop();
    await super.close();
  }
}
