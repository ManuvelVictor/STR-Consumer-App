import 'package:flutter/material.dart';
import '../../../models/RegularOrders/Cart/coupon_model.dart';
import '../../../utils/app_styles.dart';

class CouponSectionWidget extends StatelessWidget {
  final CouponModel? appliedCoupon;
  final VoidCallback onRemoveCoupon;
  final VoidCallback onEnterCode;
  final VoidCallback onViewAllCoupons;

  const CouponSectionWidget({
    super.key,
    required this.appliedCoupon,
    required this.onRemoveCoupon,
    required this.onEnterCode,
    required this.onViewAllCoupons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Best offers', style: AppStyles.headlineVerySmall),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      appliedCoupon!.code,
                      style: AppStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Saved ₹${appliedCoupon!.discount}',
                    style: AppStyles.bodyLarge.copyWith(
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onRemoveCoupon,
                child: Text(
                  'Remove',
                  style: AppStyles.bodyMedium.copyWith(
                    color: Colors.red[600],
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red[600],
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onEnterCode,
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Enter offer code",
                        style: AppStyles.bodySmall,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onViewAllCoupons,
                  child: Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "View all coupon",
                        style: AppStyles.bodySmall,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
