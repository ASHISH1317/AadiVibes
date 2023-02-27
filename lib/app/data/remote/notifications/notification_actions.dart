// ignore_for_file: flutter_style_todos

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:aadivibes/app/data/config/logger.dart';

/// Handle onMessage, onLaunch and onResume events
void notificationAction(RemoteMessage? remoteMessage) {
  //Todo(ashish): Set Firebase notification callback
  logD(remoteMessage?.data.toString() ?? 'No Data');
}

/// Handle local notification
void localNotificationAction(Map<String, dynamic>? remoteMessageData) {
  //Todo(ashish): Set local notification callback
  logD(remoteMessageData?.toString() ?? 'No Local Data');
}
