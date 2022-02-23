import 'package:leancode_chat_client/leancode_chat_client.dart';

class UserPresence {
  const UserPresence(this.lastSeen);

  final DateTime lastSeen;

  UserPresenceStatus getStatus(UserPresencePolicy presencePolicy) =>
      presencePolicy.isOnline(lastSeen)
          ? UserPresenceStatus.online
          : UserPresenceStatus.offline;
}
