// lib/providers/custom_fonts_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A StateNotifier that manages the list of custom fonts added by the user
class CustomFontsNotifier extends StateNotifier<List<String>> {
  /// Initialize with an empty list of custom fonts
  CustomFontsNotifier() : super([]) {
    _loadCustomFonts();
  }

  /// Load custom fonts from persistent storage
  Future<void> _loadCustomFonts() async {
    final prefs = await SharedPreferences.getInstance();
    final customFonts = prefs.getStringList('customFonts') ?? [];
    state = customFonts;
  }

  /// Save current custom fonts to persistent storage
  Future<void> _saveCustomFonts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('customFonts', state);
  }

  /// Add a new custom font
  /// Will not add duplicates
  Future<void> addCustomFont(String fontName) async {
    if (!state.contains(fontName)) {
      state = [...state, fontName];
      await _saveCustomFonts();
    }
  }

  /// Remove a custom font by name
  Future<void> removeCustomFont(String fontName) async {
    state = state.where((font) => font != fontName).toList();
    await _saveCustomFonts();
  }

  /// Add multiple custom fonts at once
  Future<void> addCustomFonts(List<String> fontNames) async {
    final Set<String> currentFonts = state.toSet();
    final Set<String> newFonts = {...currentFonts, ...fontNames};

    if (newFonts.length > currentFonts.length) {
      state = newFonts.toList()..sort();
      await _saveCustomFonts();
    }
  }

  /// Clear all custom fonts
  Future<void> clearCustomFonts() async {
    state = [];
    await _saveCustomFonts();
  }
}

/// A provider that exposes the list of custom fonts
final customFontsProvider =
    StateNotifierProvider<CustomFontsNotifier, List<String>>((ref) {
  return CustomFontsNotifier();
});
