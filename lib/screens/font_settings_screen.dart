// lib/screens/font_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_handbook/constants/font_constants.dart';
import 'package:flutter_handbook/font_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSettingsScreen extends ConsumerWidget {
  const FontSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSettings = ref.watch(fontSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Font Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset to defaults',
            onPressed: () {
              ref.read(fontSettingsProvider.notifier).resetToDefaults();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Font settings reset to defaults'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Fonts',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),

            // Heading Font Section
            Text(
              'Heading Font',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current: ${fontSettings.headingFont}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sample Heading',
                      style: GoogleFonts.getFont(
                        fontSettings.headingFont,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Select Font:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildFontList(
                      context,
                      ref,
                      fontSettings.headingFont,
                      (font) => ref
                          .read(fontSettingsProvider.notifier)
                          .updateHeadingFont(font),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Body Font Section
            Text(
              'Body Font',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current: ${fontSettings.bodyFont}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This is a sample paragraph text that demonstrates how your body font will appear throughout the app. The body font is used for all regular content text.',
                      style: GoogleFonts.getFont(
                        fontSettings.bodyFont,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Select Font:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildFontList(
                      context,
                      ref,
                      fontSettings.bodyFont,
                      (font) => ref
                          .read(fontSettingsProvider.notifier)
                          .updateBodyFont(font),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Note: Font changes will be applied throughout the app immediately.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontList(
    BuildContext context,
    WidgetRef ref,
    String currentFont,
    Function(String) onFontSelected,
  ) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        itemCount: FontConstants.defaultFonts.length,
        itemBuilder: (context, index) {
          final font = FontConstants.defaultFonts[index];
          final isSelected = font == currentFont;

          return ListTile(
            title: Text(
              font,
              style: GoogleFonts.getFont(
                font,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            selected: isSelected,
            onTap: () {
              onFontSelected(font);
            },
          );
        },
      ),
    );
  }
}
