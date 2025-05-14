// lib/theme/app_typography.dart
import 'package:flutter/material.dart';
import 'package:flutter_handbook/core/constants/font_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme getTextTheme({
    required Brightness brightness,
    required String headingFont,
    required String bodyFont,
  }) {
    final bool isLight = brightness == Brightness.light;
    final Color primaryTextColor =
        isLight ? const Color(0xFF212121) : const Color(0xFFE1E1E1);
    final Color secondaryTextColor =
        isLight ? const Color(0xFF757575) : const Color(0xFFAEAEAE);

    return TextTheme(
      displayLarge: GoogleFonts.getFont(
        headingFont,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displayMedium: GoogleFonts.getFont(
        headingFont,
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
      displaySmall: GoogleFonts.getFont(
        headingFont,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
      ),
      headlineMedium: GoogleFonts.getFont(
        headingFont,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: GoogleFonts.getFont(
        headingFont,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleLarge: GoogleFonts.getFont(
        headingFont,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: GoogleFonts.getFont(
        headingFont,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      titleSmall: GoogleFonts.getFont(
        bodyFont,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
      bodyLarge: GoogleFonts.getFont(
        bodyFont,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
      ),
      bodyMedium: GoogleFonts.getFont(
        bodyFont,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
      ),
      bodySmall: GoogleFonts.getFont(
        bodyFont,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
      ),
      labelLarge: GoogleFonts.getFont(
        bodyFont,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
    );
  }

  // Default themes for reference
  static TextTheme get lightTextTheme => getTextTheme(
        brightness: Brightness.light,
        headingFont: FontConstants.defaultHeadingFont,
        bodyFont: FontConstants.defaultBodyFont,
      );

  static TextTheme get darkTextTheme => getTextTheme(
        brightness: Brightness.dark,
        headingFont: FontConstants.defaultHeadingFont,
        bodyFont: FontConstants.defaultBodyFont,
      );
}
