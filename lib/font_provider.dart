// lib/providers/font_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_handbook/constants/font_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSettings {
  final String headingFont;
  final String bodyFont;

  FontSettings({
    required this.headingFont,
    required this.bodyFont,
  });

  FontSettings copyWith({
    String? headingFont,
    String? bodyFont,
  }) {
    return FontSettings(
      headingFont: headingFont ?? this.headingFont,
      bodyFont: bodyFont ?? this.bodyFont,
    );
  }
}

class FontSettingsNotifier extends StateNotifier<FontSettings> {
  FontSettingsNotifier()
      : super(
          FontSettings(
            headingFont: FontConstants.defaultHeadingFont,
            bodyFont: FontConstants.defaultBodyFont,
          ),
        ) {
    _loadFontSettings();
  }

  Future<void> _loadFontSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final headingFont =
        prefs.getString('headingFont') ?? FontConstants.defaultHeadingFont;
    final bodyFont =
        prefs.getString('bodyFont') ?? FontConstants.defaultBodyFont;

    state = FontSettings(
      headingFont: headingFont,
      bodyFont: bodyFont,
    );
  }

  Future<void> _saveFontSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('headingFont', state.headingFont);
    await prefs.setString('bodyFont', state.bodyFont);
  }

  Future<void> updateHeadingFont(String font) async {
    state = state.copyWith(headingFont: font);
    await _saveFontSettings();
  }

  Future<void> updateBodyFont(String font) async {
    state = state.copyWith(bodyFont: font);
    await _saveFontSettings();
  }

  Future<void> resetToDefaults() async {
    state = FontSettings(
      headingFont: FontConstants.defaultHeadingFont,
      bodyFont: FontConstants.defaultBodyFont,
    );
    await _saveFontSettings();
  }
}

final fontSettingsProvider =
    StateNotifierProvider<FontSettingsNotifier, FontSettings>((ref) {
  return FontSettingsNotifier();
});
