import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/core/di/injection_container.dart' as di;
import 'package:flutter_notification/core/routes/app_router.dart';
import 'package:flutter_notification/core/theme/app_theme.dart';
import 'package:flutter_notification/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_notification/features/notification/domain/repositories/notification_repository.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();
  logger.d('Dependencies initialized');

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize notification service
  final notificationRepository = di.sl<NotificationRepository>();
  try {
    logger.d('Requesting notification permission');
    await notificationRepository.requestPermission();
  } catch (e) {
    logger.e('Error requesting notification permission: $e');
  }

  // Get FCM token
  final token = await notificationRepository.getToken();
  logger.d('Firebase token: $token');

  // Set up message handlers
  await notificationRepository.setupMessageHandlers(_handleMessage);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Don't create notification here as it will be handled by the system automatically
}

void _handleMessage(RemoteMessage message) {
  // Handle notification click here
  logger.d('Handling notification click: ${message.notification?.title}');
  // You can add navigation logic here based on the notification data
  if (message.data.containsKey('route')) {
    // Navigate to specific route based on data
    logger.d('Route: ${message.data['route']}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Notification',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
