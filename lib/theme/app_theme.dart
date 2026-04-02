import 'package:flutter/material.dart';

/// App Theme and Colors
class AppTheme {
  // Brand Colors
  static const Color red = Color(0xFFFF2D20);
  static const Color redSoft = Color(0x16FF2D20);
  static const Color redBorder = Color(0x40FF2D20);
  static const Color redGlow = Color(0x33FF2D20);
  
  static const Color teal = Color(0xFF00D4AA);
  static const Color tealSoft = Color(0x1A00D4AA);
  static const Color tealBorder = Color(0x4D00D4AA);

  // Background Layers
  static const Color bg0 = Color(0xFF080810);
  static const Color bg1 = Color(0xFF0e0e18);
  static const Color bg2 = Color(0xFF13131f);
  static const Color bg3 = Color(0xFF181826);
  static const Color bg4 = Color(0xFF1d1d2e);
  static const Color bgCard = Color(0xFF111120);

  // Borders
  static const Color b1 = Color(0x0Fffffff);
  static const Color b2 = Color(0x1Affffff);
  static const Color b3 = Color(0x29ffffff);

  // Text
  static const Color t1 = Color(0xFFf2f2ff);
  static const Color t2 = Color(0xFF9494b0);
  static const Color t3 = Color(0xFF484864);

  // Category Colors
  static const Color cSpam = Color(0xFFFF2D20);
  static const Color cPromo = Color(0xFFFF7A00);
  static const Color cHate = Color(0xFFF5C400);
  static const Color cGibberish = Color(0xFF2196F3);
  static const Color cDuplicate = Color(0xFF9B59E8);
  static const Color cClean = Color(0xFF00C97A);

  // Semantic Colors
  static const Color green = Color(0xFF00C97A);
  static const Color greenSoft = Color(0x1A00C97A);
  static const Color blue = Color(0xFF2196F3);
  static const Color blueSoft = Color(0x1A2196F3);
  static const Color orange = Color(0xFFFF7A00);
  static const Color orangeSoft = Color(0x1AFF7A00);
  static const Color yellow = Color(0xFFF5C400);
  static const Color yellowSoft = Color(0x1AF5C400);
  static const Color purple = Color(0xFF9B59E8);
  static const Color purpleSoft = Color(0x1A9B59E8);

  // Get category color
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'spam':
        return cSpam;
      case 'promo':
        return cPromo;
      case 'hate':
        return cHate;
      case 'gibberish':
        return cGibberish;
      case 'duplicate':
        return cDuplicate;
      case 'clean':
        return cClean;
      default:
        return t2;
    }
  }

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg0,
      primaryColor: red,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: t1,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: t1,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: t1,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: t1,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: t2,
        ),
      ),
    );
  }
}
