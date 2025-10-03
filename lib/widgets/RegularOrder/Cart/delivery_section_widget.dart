import 'package:flutter/material.dart';
import '../../../models/RegularOrders/Cart/delivery_address_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class DeliverySectionWidget extends StatelessWidget {
  final DeliveryAddressModel deliveryAddress;
  final VoidCallback onEdit;

  const DeliverySectionWidget({
    super.key,
    required this.deliveryAddress,
    required this.onEdit,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery at Home', style: AppStyles.headlineVerySmall),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20, color: AppColors.progressBlack),
                    const SizedBox(width: 4),
                    Text("Edit", style: AppStyles.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.progressBlack,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  deliveryAddress.address,
                  style: AppStyles.bodyMedium.copyWith(color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.phone_in_talk_outlined,
                color: AppColors.progressBlack,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                deliveryAddress.phone,
                style: AppStyles.bodyMedium.copyWith(color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
