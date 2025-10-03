import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../../models/RegularOrders/Coupon/coupon_model.dart';

class CouponItemWidget extends StatelessWidget {
  final CouponModel coupon;
  final bool isApplied;
  final VoidCallback onApply;

  const CouponItemWidget({
    super.key,
    required this.coupon,
    required this.isApplied,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(coupon.code, style: AppStyles.bodyLarge),
                ),
                const SizedBox(width: 10),
                Text(
                  coupon.discountText,
                  style: AppStyles.bodyLarge.copyWith(
                    color: Colors.green.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(coupon.description, style: AppStyles.bodyMedium),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: coupon.isApplicable ? onApply : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: coupon.isApplicable
                      ? AppColors.primaryOrange
                      : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  isApplied ? "Applied" : "Apply",
                  style: AppStyles.bodyMedium.copyWith(
                    color: coupon.isApplicable ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
