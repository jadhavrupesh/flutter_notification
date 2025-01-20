import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void navigateToRoute(String route) {
    if (navigatorKey.currentContext != null) {
      GoRouter.of(navigatorKey.currentContext!).push(route);
    }
  }
}
