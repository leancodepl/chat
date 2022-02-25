import 'package:clock/clock.dart';

mixin UserPresencePolicy {
  /// Specifies how frequently should the client ping the server
  /// with the information that he is still active.
  Duration get pingInterval;

  /// Specifies how frequently should the client refresh users'
  /// statuses by comparing the time they have been last seen
  /// with the current time.
  Duration get statusRefreshInterval;

  /// Defines when we consider user to be online.
  ///
  /// `lastSeen` is the timestamp of the last ping by the client
  /// to the server.
  bool isOnline(DateTime lastSeen);
}

/// Default user presence policy with the accuracy of ~1.5 min.
///
/// Users will be marked as offline after at most 1.5 min after
/// they go offline (close the app, lose connection to the internet etc.)
class DefaultUserPresencePolicy with UserPresencePolicy {
  const DefaultUserPresencePolicy({
    this.pingInterval = defaultInterval,
    this.statusRefreshInterval = defaultStatusRefreshInterval,
  });

  static const Duration defaultInterval = Duration(minutes: 1);
  static const Duration defaultStatusRefreshInterval = Duration(seconds: 30);

  @override
  final Duration pingInterval;

  @override
  final Duration statusRefreshInterval;

  @override
  bool isOnline(DateTime lastSeen) {
    return lastSeen.isAfter(clock.now().subtract(pingInterval));
  }
}
