import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepository {
  Future<void> initialize();
  Future<String?> getToken();
  Future<void> requestPermission();
  Future<void> setupMessageHandlers(Function(RemoteMessage) onMessageHandler);
  Future<void> showNotification(RemoteMessage message);

  Future<RemoteMessage?> getInitialMessage();
}
