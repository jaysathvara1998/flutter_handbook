// lib/constants/font_constants.dart
import 'package:flutter/material.dart';

class FontConstants {
  // Default set of fonts available in the app
  static const List<String> defaultFonts = [
    'Montserrat',
    'Underdog',
    'Roboto',
    'Lato',
    'Poppins',
    'Open Sans',
    'Raleway',
    'Ubuntu',
    'Nunito',
    'Source Code Pro'
  ];

  // Default fonts used when app is first installed
  static const String defaultHeadingFont = 'Montserrat';
  static const String defaultBodyFont = 'Open Sans';

  // Get all available fonts (default + custom)
  static List<String> getAllFonts(List<String> customFonts) {
    final allFonts = List<String>.from(defaultFonts);

    // Add custom fonts
    for (final font in customFonts) {
      if (!allFonts.contains(font)) {
        allFonts.add(font);
      }
    }

    // Sort alphabetically for easier selection
    allFonts.sort();

    return allFonts;
  }

  // Font weights commonly used throughout the app
  static const FontWeight headingWeight = FontWeight.w600;
  static const FontWeight titleWeight = FontWeight.w600;
  static const FontWeight bodyWeight = FontWeight.normal;
  static const FontWeight labelWeight = FontWeight.w500;

  // Font sizes for responsive text scaling
  static const double baseFontSize = 14.0;
  static const double fontScaleSmall = 0.85;
  static const double fontScaleLarge = 1.25;

  // Helper method to get appropriate font size based on accessibility settings
  static double getFontSize(double baseSize, double textScaleFactor) {
    return baseSize * textScaleFactor;
  }
}
