import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../chat_client.dart';

/// Refreshes the online status of the current user by periodically
/// pinging the server.
///
/// It needs to be manually started by calling [start].
class UserPresenceSynchronizer with WidgetsBindingObserver {
  UserPresenceSynchronizer(this._widgetsBinding, this._chatClient) {
    _widgetsBinding.addObserver(this);
  }

  final WidgetsBinding _widgetsBinding;
  final ChatClient _chatClient;

  Timer? _timer;
  bool _isStarted = false;
  final _logger = Logger('UserPresenceSynchronizer');

  Future<void> start() async {
    _isStarted = true;
    await _updatePresence();

    _startTimer();
  }

  void stop() {
    _isStarted = false;
    _stopTimer();
  }

  Future<void> dispose() async {
    _widgetsBinding.removeObserver(this);
    _stopTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isStarted) {
      return;
    }

    if (state == AppLifecycleState.resumed) {
      _updatePresence();
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  void _onTick(Timer timer) => _updatePresence();

  void _startTimer() {
    _timer = Timer.periodic(
      _chatClient.presencePolicy.pingInterval,
      _onTick,
    );
  }

  void _stopTimer() => _timer?.cancel();

  Future<void> _updatePresence() {
    _logger.info('Presence ping');

    return _chatClient.updatePresence()
      ..catchError(
        // ignore: avoid_types_on_closure_parameters
        (dynamic e, StackTrace st) {
          _logger.warning('Failed to update presence', e, st);
        },
      );
  }
}
