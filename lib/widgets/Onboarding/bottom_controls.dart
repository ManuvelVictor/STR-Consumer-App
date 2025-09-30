import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class BottomControls extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const BottomControls({super.key, required this.onSkip, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onSkip,
              child: Text(
                "Skip",
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.lightWhite,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onNext,
              style: AppStyles.primaryButtonStyle.copyWith(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.primaryOrange,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
