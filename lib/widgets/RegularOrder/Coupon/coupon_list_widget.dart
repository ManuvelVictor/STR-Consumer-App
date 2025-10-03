import 'package:flutter/material.dart';
import '../../../models/RegularOrders/Coupon/coupon_model.dart';
import 'coupon_item_widget.dart';

class CouponListWidget extends StatelessWidget {
  final List<CouponModel> coupons;
  final String? appliedCoupon;
  final Function(String code) onApply;

  const CouponListWidget({
    super.key,
    required this.coupons,
    required this.appliedCoupon,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return CouponItemWidget(
          coupon: coupon,
          isApplied: appliedCoupon == coupon.code,
          onApply: () => onApply(coupon.code),
        );
      },
    );
  }
}
