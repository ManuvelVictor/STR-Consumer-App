import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class LocationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LocationButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 24,
                    color: AppColors.textBlack,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Enable location",
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.textBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
