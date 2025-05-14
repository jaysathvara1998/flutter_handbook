import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationUtil {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Navigate to named route with optional params
  static void goToNamed(String routeName,
      {Map<String, String>? params,
      Map<String, String>? queryParams,
      Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.goNamed(routeName,
          pathParameters: params ?? {},
          queryParameters: queryParams ?? {},
          extra: extra);
    }
  }

  /// Push a new named route
  static void pushNamed(String routeName,
      {Map<String, String>? params,
      Map<String, String>? queryParams,
      Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.pushNamed(routeName,
          pathParameters: params ?? {},
          queryParameters: queryParams ?? {},
          extra: extra);
    }
  }

  /// Go to path directly
  static void goToPath(String path) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go(path);
    }
  }

  /// Push to path directly
  static void pushPath(String path) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.push(path);
    }
  }

  /// Go back (pop current screen)
  static void goBack() {
    final context = navigatorKey.currentContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
