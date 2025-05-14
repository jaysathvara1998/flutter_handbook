import 'package:flutter/material.dart';
import 'package:flutter_handbook/providers/theme_provider.dart';
import 'package:flutter_handbook/screens/font_cache_screen.dart';
import 'package:flutter_handbook/screens/font_settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Theme Settings
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme'),
            subtitle: Text(
              _getThemeModeName(ref.watch(themeModeProvider)),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showThemeModal(context, ref);
            },
          ),

          const Divider(),

          // Font Settings
          ListTile(
            leading: const Icon(Icons.font_download),
            title: const Text('Font Settings'),
            subtitle: const Text('Customize app fonts'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FontSettingsScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // Font Cache Management
          ListTile(
            leading: const Icon(Icons.cached),
            title: const Text('Font Cache'),
            subtitle: const Text('Manage font caching'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FontCacheScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('App information & licenses'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flutter Handbook',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.menu_book_rounded,
                  size: 50,
                  color: Colors.purple,
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'A comprehensive guide to Flutter development with customizable themes and fonts.',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  void _showThemeModal(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(themeModeProvider);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Choose Theme',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              // System theme option
              RadioListTile<ThemeMode>(
                title: const Text('System'),
                subtitle: const Text('Follow system settings'),
                value: ThemeMode.system,
                groupValue: currentTheme,
                onChanged: (value) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value!);
                  Navigator.pop(context);
                },
              ),

              // Light theme option
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                subtitle: const Text('Light theme for all times'),
                value: ThemeMode.light,
                groupValue: currentTheme,
                onChanged: (value) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value!);
                  Navigator.pop(context);
                },
              ),

              // Dark theme option
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                subtitle: const Text('Dark theme for all times'),
                value: ThemeMode.dark,
                groupValue: currentTheme,
                onChanged: (value) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
