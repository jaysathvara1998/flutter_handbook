// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handbook/firebase_options.dart';
import 'package:flutter_handbook/font_provider.dart';
import 'package:flutter_handbook/providers/theme_provider.dart';
import 'package:flutter_handbook/screens/splash_screen.dart';
import 'package:flutter_handbook/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Create a provider that combines theme mode and font settings
final appThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  final fontSettings = ref.watch(fontSettingsProvider);

  final brightness = switch (themeMode) {
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
    ThemeMode.system =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
  };

  return AppTheme.getTheme(
    brightness: brightness,
    headingFont: fontSettings.headingFont,
    bodyFont: fontSettings.bodyFont,
  );
});

final darkThemeProvider = Provider<ThemeData>((ref) {
  final fontSettings = ref.watch(fontSettingsProvider);

  return AppTheme.getTheme(
    brightness: Brightness.dark,
    headingFont: fontSettings.headingFont,
    bodyFont: fontSettings.bodyFont,
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(appThemeProvider);
    final darkTheme = ref.watch(darkThemeProvider);

    return MaterialApp(
      title: 'Flutter Handbook',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
