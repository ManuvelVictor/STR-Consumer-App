import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import 'package:str_customer_app/widgets/RegularOrder/ProductDetail/product_rating.dart';
import '../../../models/RegularOrders/ProductDetail/product_model.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: AppStyles.headlineSmall),
          const SizedBox(height: 6),
          ProductRating(rating: product.rating, count: product.ratingCount),
          const SizedBox(height: 6),
          Text("₹ ${product.price}", style: AppStyles.headlineSmall),
          const SizedBox(height: 12),
          Text("Description", style: AppStyles.headlineSmall),
          const SizedBox(height: 6),
          Text(
            product.description,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
