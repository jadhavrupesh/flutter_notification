import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_router.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Don't create notification here as it will be handled by the system automatically
}

void _handleMessage(RemoteMessage message) {
  // Handle notification click here
  print('Handling notification click: ${message.notification?.title}');
  // You can add navigation logic here based on the notification data
  if (message.data.containsKey('route')) {
    // Navigate to specific route based on data
    print('Route: ${message.data['route']}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize notification service
  final notificationRepository = di.sl<NotificationRepository>();
  await notificationRepository.initialize();
  await notificationRepository.requestPermission();

  // Get FCM token
  final token = await notificationRepository.getToken();
  print('FCM Token: $token');

  // Set up message handlers
  await notificationRepository.setupMessageHandlers(_handleMessage);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.deepRed,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Notification',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepRed),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
