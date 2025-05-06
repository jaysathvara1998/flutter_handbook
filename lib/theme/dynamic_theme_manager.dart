import 'package:flutter/material.dart';
import 'package:flutter_handbook/providers/font_provider.dart';
import 'package:flutter_handbook/providers/theme_provider.dart';
import 'package:flutter_handbook/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that dynamically creates the light theme based on font settings
final dynamicLightThemeProvider = Provider<ThemeData>((ref) {
  final fontSettings = ref.watch(fontSettingsProvider);

  return AppTheme.getTheme(
    brightness: Brightness.light,
    headingFont: fontSettings.headingFont,
    bodyFont: fontSettings.bodyFont,
  );
});

/// A provider that dynamically creates the dark theme based on font settings
final dynamicDarkThemeProvider = Provider<ThemeData>((ref) {
  final fontSettings = ref.watch(fontSettingsProvider);

  return AppTheme.getTheme(
    brightness: Brightness.dark,
    headingFont: fontSettings.headingFont,
    bodyFont: fontSettings.bodyFont,
  );
});

/// A widget that rebuilds whenever the theme or font settings change
class DynamicThemeManager extends ConsumerWidget {
  final Widget child;

  const DynamicThemeManager({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(dynamicLightThemeProvider);
    final darkTheme = ref.watch(dynamicDarkThemeProvider);

    return MaterialApp(
      title: 'Flutter Handbook',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: child,
    );
  }
}
