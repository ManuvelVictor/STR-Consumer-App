import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Colors.orange;
  static const Color primaryLight = Color(0xFFFFE0B2);
  static const Color primaryOrange = Color(0xFFFC9622);
  static const Color secondary = Color(0xFF2D2D2D);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F2F8);
  static const Color lightWhite = Color(0xFFF1F2F8);

  // Semantic Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFCDD2);

  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFC8E6C9);

  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFE0B2);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFBBDEFB);

  static const Color progressBlack = Color(0x8A000000);

  static const Color gold = Color(0xFFffb90b);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textBlack = Color(0xDD000000);

  // Borders, Dividers & Shadows
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFCCCCCC);
  static const Color shadow = Color(0x1A000000);

  // States
  static const Color disabled = Color(0xFFE0E0E0);
  static const Color selected = Color(0xFFE65100);
  static const Color highlight = Color(0xFFFFF3E0);

  // Gradients (can be used with LinearGradient)
  static const List<Color> primaryGradient = [
    Color(0xFFFF9800),
    Color(0xFFFF5722),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF4A148C),
    Color(0xFF7B1FA2),
  ];

  // Neutral Palette (useful for backgrounds / skeletons)
  static const Color neutral100 = Color(0xFFFFFFFF);
  static const Color neutral200 = Color(0xFFF5F5F5);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
}