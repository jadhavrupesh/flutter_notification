import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/core/theme/app_colors.dart';
import 'package:flutter_notification/core/constants/notification_constants.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseMessaging _firebaseMessaging;
  final AwesomeNotifications _awesomeNotifications;

  NotificationRepositoryImpl({
    required FirebaseMessaging firebaseMessaging,
    required AwesomeNotifications awesomeNotifications,
  })  : _firebaseMessaging = firebaseMessaging,
        _awesomeNotifications = awesomeNotifications;

  @override
  Future<void> initialize() async {
    await _awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: NotificationConstants.basicChannelKey,
          channelName: NotificationConstants.basicChannelName,
          channelDescription: NotificationConstants.basicChannelDescription,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          enableVibration: true,
          channelShowBadge: true,
          enableLights: true,
          icon: NotificationConstants.defaultIconPath,
          playSound: true,
          soundSource: NotificationConstants.defaultSoundPath,
        ),
      ],
    );
  }

  @override
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  @override
  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Future<void> setupMessageHandlers(
      Function(RemoteMessage) onMessageHandler) async {
    // Handle notification open when app is terminated
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      onMessageHandler(initialMessage);
    }

    // Handle notification open when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) async {
      await showNotification(message);
    });
  }

  @override
  Future<void> showNotification(RemoteMessage message) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
          id: message.hashCode,
          channelKey: NotificationConstants.basicChannelKey,
          title: message.notification?.title ??
              NotificationConstants.defaultNotificationTitle,
          body: message.notification?.body ?? '',
          icon: NotificationConstants.defaultIconPath,
          category: NotificationCategory.Message,
          displayOnForeground: true,
          displayOnBackground: true,
          customSound: NotificationConstants.defaultSoundPath,
          wakeUpScreen: true,
          color: AppColors.deepRed),
    );
  }
}
