import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_handbook/constants/color_constants.dart';
import 'package:flutter_handbook/constants/font_constants.dart';
import 'package:flutter_handbook/theme/app_typography.dart';

class AppTheme {
  static ThemeData getTheme({
    required Brightness brightness,
    required String headingFont,
    required String bodyFont,
  }) {
    final bool isLight = brightness == Brightness.light;
    print('TM ===> HeadingFont :: $headingFont BodyFont :: $bodyFont');
    if (isLight) {
      return ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorConstants.primaryLight,
          onPrimary: Colors.white,
          secondary: ColorConstants.secondaryLight,
          onSecondary: Colors.black,
          error: ColorConstants.errorLight,
          onError: Colors.white,
          background: ColorConstants.backgroundLight,
          onBackground: ColorConstants.textPrimaryLight,
          surface: ColorConstants.surfaceLight,
          onSurface: ColorConstants.textPrimaryLight,
        ),
        scaffoldBackgroundColor: ColorConstants.backgroundLight,
        textTheme: AppTypography.lightTextTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConstants.primaryLight,
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        cardTheme: CardTheme(
          color: ColorConstants.cardLight,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.primaryLight,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorConstants.accentLight,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: ColorConstants.dividerLight,
          thickness: 1,
          space: 1,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: ColorConstants.surfaceLight,
          collapsedBackgroundColor: ColorConstants.surfaceLight,
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          childrenPadding: EdgeInsets.fromLTRB(24, 0, 24, 16),
          expandedAlignment: Alignment.topLeft,
          iconColor: ColorConstants.primaryLight,
          collapsedIconColor: ColorConstants.textSecondaryLight,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          iconColor: ColorConstants.primaryLight,
          tileColor: ColorConstants.surfaceLight,
        ),
      );
    }
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: ColorConstants.primaryDark,
        onPrimary: Colors.black,
        secondary: ColorConstants.secondaryDark,
        onSecondary: Colors.black,
        error: ColorConstants.errorDark,
        onError: Colors.black,
        background: ColorConstants.backgroundDark,
        onBackground: ColorConstants.textPrimaryDark,
        surface: ColorConstants.surfaceDark,
        onSurface: ColorConstants.textPrimaryDark,
      ),
      scaffoldBackgroundColor: ColorConstants.backgroundDark,
      textTheme: AppTypography.darkTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorConstants.surfaceDark,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardTheme(
        color: ColorConstants.cardDark,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryDark,
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorConstants.accentDark,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ColorConstants.dividerDark,
        thickness: 1,
        space: 1,
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: ColorConstants.surfaceDark,
        collapsedBackgroundColor: ColorConstants.surfaceDark,
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        childrenPadding: EdgeInsets.fromLTRB(24, 0, 24, 16),
        expandedAlignment: Alignment.topLeft,
        iconColor: ColorConstants.primaryDark,
        collapsedIconColor: ColorConstants.textSecondaryDark,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        iconColor: ColorConstants.primaryDark,
        tileColor: ColorConstants.surfaceDark,
      ),
    );
  }

  // Default themes
  static ThemeData get lightTheme => getTheme(
        brightness: Brightness.light,
        headingFont: FontConstants.defaultHeadingFont,
        bodyFont: FontConstants.defaultBodyFont,
      );

  static ThemeData get darkTheme => getTheme(
        brightness: Brightness.dark,
        headingFont: FontConstants.defaultHeadingFont,
        bodyFont: FontConstants.defaultBodyFont,
      );
}
