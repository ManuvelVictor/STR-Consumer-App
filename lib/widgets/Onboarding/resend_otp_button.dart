import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_styles.dart';

import '../../utils/app_colors.dart';

class ResendOtpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ResendOtpButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't get the code? ",
          style: AppStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: isLoading ? null : onPressed,
          child: isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
              : Text(
                  "Resend OTP",
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryOrange
                  ),
                ),
        ),
      ],
    );
  }
}
