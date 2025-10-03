import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {

  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static final TextStyle skipText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle headlineVerySmall = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle appbarText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle cartAmount = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle cartProductName = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );


  static final TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
  );

  static final TextStyle bodyMediumButton = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Button styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryOrange,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryLight,
    foregroundColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: AppColors.primary),
    ),
  );

  // Container decorations
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.divider),
  );
}