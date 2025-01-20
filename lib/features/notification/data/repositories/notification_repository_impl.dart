import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification/core/constants/notification_constants.dart';
import 'package:flutter_notification/core/theme/app_colors.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/notification_repository.dart';

final logger = Logger();

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
    logger.d('Initializing notification service');
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
    final token = await _firebaseMessaging.getToken();
    logger.d('Firebase token: $token');
    return token;
  }

  @override
  Future<void> requestPermission() async {
    logger.d('Requesting notification permissions');
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
    logger.d('Handling initial message called');
    if (initialMessage != null) {
      logger.d('Handling initial message: ${initialMessage.messageId}');
      onMessageHandler(initialMessage);
    }

    // Handle notification open when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      logger.d('Handling background message: ${message.messageId}');
      onMessageHandler(message);
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) async {
      logger.d('Handling foreground message: ${message.messageId}');
      await showNotification(message);
    });
  }

  @override
  Future<void> showNotification(RemoteMessage message) async {
    try {
      logger.d('Showing notification: ${message.notification?.title}');
      // Show notification on the device
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
          color: AppColors.deepRed,
        ),
      );
    } catch (e, stackTrace) {
      logger.e('Error showing notification', error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async {
    return await _firebaseMessaging.getInitialMessage();
  }
}
