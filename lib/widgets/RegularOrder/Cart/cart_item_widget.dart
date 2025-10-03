import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import '../../../models/RegularOrders/Cart/product_model.dart';
import '../../../utils/app_styles.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool isLast;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.onIncrement,
    required this.onDecrement,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 12.0, 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppStyles.cartProductName,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ ${product.price}',
                    style: AppStyles.cartAmount,
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.primaryOrange, width: 1.2),
                ),
                child: Row(
                  children: [
                    _circleButton(Icons.remove, onDecrement),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${product.quantity}',
                        style: AppStyles.cartAmount
                      ),
                    ),
                    _circleButton(Icons.add, onIncrement),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (!isLast) const Divider(thickness: 0.5, height: 10),
      ],
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: AppColors.primaryOrange, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
