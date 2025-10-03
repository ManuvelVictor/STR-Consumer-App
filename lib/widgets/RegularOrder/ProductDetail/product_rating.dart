import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../../utils/app_colors.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int count;

  const ProductRating({super.key, required this.rating, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.gold, size: 20),
        Text("$rating", style: AppStyles.bodyMedium),
        const SizedBox(width: 8),
        Text("($count ratings)", style: AppStyles.bodySmall),
      ],
    );
  }
}
