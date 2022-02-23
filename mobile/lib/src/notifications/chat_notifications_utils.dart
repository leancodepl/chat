import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('leancode_chat_client');

/// Clears all received push notifications in a group
///
/// For explanation of notification tags on Android, see https://developer.android.com/reference/android/app/NotificationManager
/// Minimum Android SDK version must be 23 (Marshmallow)
///
/// On iOS, `tag` represents the `threadIdentifier` https://developer.apple.com/documentation/usernotifications/unnotificationcontent/1649860-threadidentifier
/// In a push notification JSON payload the parameter `thread-id` is used
Future<void> clearNotificationsWithTag(String tag) {
  return _channel.invokeMethod('clearNotificationsWithTag', {'tag': tag});
}
