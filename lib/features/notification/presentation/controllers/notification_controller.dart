import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/navigation_service.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification created: ${receivedNotification.id}');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed: ${receivedNotification.id}');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Notification dismissed: ${receivedAction.id}');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Action received: ${receivedAction.payload}');
    if (receivedAction.payload?['deepLink'] != null) {
      final deepLink = receivedAction.payload!['deepLink']!;
      if (deepLink.contains('forget_password')) {
        NavigationService.navigateToRoute('/forgot-password');
      }
    }
  }
}
