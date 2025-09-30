import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "Skip for now",
        style: AppStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
