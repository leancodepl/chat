import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../chat_client.dart';
import 'user_presence_synchronizer.dart';

/// Tracks current user presence during the lifetime of the hook
///
/// User is considered to be present when the app is open in the foreground.
void useUserPresence(
  ChatClient<dynamic, dynamic> client,
  WidgetsBinding widgetsBinding, {
  List<Object?>? keys = const [],
}) {
  useEffect(() {
    final synchronizer = UserPresenceSynchronizer(widgetsBinding, client)
      ..start();

    return synchronizer.dispose;
  }, keys);
}
