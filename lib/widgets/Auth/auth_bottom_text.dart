import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class AuthBottomText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthBottomText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: AppStyles.bodyMedium),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
