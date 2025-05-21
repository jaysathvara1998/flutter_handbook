import 'package:flutter_handbook/core/constants/route_constants.dart';
import 'package:flutter_handbook/core/utils/navigation_util.dart';
import 'package:flutter_handbook/screens/home_screen.dart';
import 'package:flutter_handbook/screens/settings_screen.dart';
import 'package:flutter_handbook/screens/splash_screen.dart';
import 'package:flutter_handbook/screens/topic_detail_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigationUtil.navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Routes.initial,
      name: RouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.home,
      name: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.topic,
      name: RouteName.topic,
      builder: (context, state) {
        // final topic = state.extra as Topic;
        // return TopicDetailScreen(topic: topic);
        final id = state.pathParameters['id']!;
        return TopicDetailScreen(topicId: id);
      },
    ),
    GoRoute(
      path: Routes.settings,
      name: RouteName.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
