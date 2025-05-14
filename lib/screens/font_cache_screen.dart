import 'package:flutter/material.dart';
import 'package:flutter_handbook/core/constants/font_constants.dart';
import 'package:flutter_handbook/providers/custom_fonts_provider.dart';
import 'package:flutter_handbook/services/font_cache_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FontCacheScreen extends ConsumerStatefulWidget {
  const FontCacheScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FontCacheScreen> createState() => _FontCacheScreenState();
}

class _FontCacheScreenState extends ConsumerState<FontCacheScreen> {
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    final customFonts = ref.watch(customFontsProvider);
    final allFonts = FontConstants.getAllFonts(customFonts);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Font Cache Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Font Cache',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Flutter Handbook caches font data to improve performance and reduce internet usage. '
              'You can manage the cache here.',
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Fonts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Default fonts: ${FontConstants.defaultFonts.length}'),
                    Text('Custom fonts: ${customFonts.length}'),
                    Text('Total fonts: ${allFonts.length}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Processing fonts...'),
                  ],
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Preload All Fonts'),
                    onPressed: () => _preloadFonts(allFonts),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Clear Font Cache'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    onPressed: _clearCache,
                  ),
                ],
              ),
            if (_statusMessage.isNotEmpty) ...[
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(_statusMessage),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _preloadFonts(List<String> fonts) async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      await FontCacheService.preloadFonts(fonts);
      setState(() {
        _statusMessage = 'Successfully preloaded ${fonts.length} fonts.';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error preloading fonts: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _clearCache() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      await FontCacheService.clearCache();
      setState(() {
        _statusMessage = 'Font cache cleared successfully.';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error clearing font cache: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
