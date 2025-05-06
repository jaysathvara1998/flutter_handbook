import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that manages caching and preloading of fonts
class FontCacheService {
  static const String _lastUpdatedKey = 'font_cache_last_updated';
  static const Duration _cacheValidityPeriod = Duration(days: 7);

  /// Preload common fonts to improve performance
  static Future<void> preloadFonts(List<String> fontFamilies) async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdated = prefs.getInt(_lastUpdatedKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Check if cache is still valid
    if (now - lastUpdated > _cacheValidityPeriod.inMilliseconds) {
      for (final fontFamily in fontFamilies) {
        try {
          // Load font config into cache
          GoogleFonts.getFont(fontFamily).fontFamily;

          // Delay slightly to prevent overloading
          await Future.delayed(const Duration(milliseconds: 50));
        } catch (e) {
          // Ignore font loading errors
          print('Failed to preload font: $fontFamily');
        }
      }

      // Update last updated timestamp
      await prefs.setInt(_lastUpdatedKey, now);
    }
  }

  /// Clear the font cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastUpdatedKey);
  }
}
