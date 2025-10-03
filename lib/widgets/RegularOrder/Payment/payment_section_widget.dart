import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../../models/RegularOrders/Payment/payment_method_model.dart';
import 'payment_method_tile.dart';

class PaymentSectionWidget extends StatelessWidget {
  final String title;
  final List<PaymentMethodModel> methods;
  final String? selectedMethodId;
  final Function(String) onSelect;
  final VoidCallback? onAddNew;
  final String? addNewText;

  const PaymentSectionWidget({
    super.key,
    required this.title,
    required this.methods,
    required this.selectedMethodId,
    required this.onSelect,
    this.onAddNew,
    this.addNewText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.headlineVerySmall
            ),
            const SizedBox(height: 8),
            ...methods.map(
              (method) => PaymentMethodTile(
                method: method,
                isSelected: selectedMethodId == method.id,
                onSelect: () => onSelect(method.id),
              ),
            ),
            if (onAddNew != null && addNewText != null) ...[
              Divider(thickness: 0.5, height: 1,color: AppColors.divider,),
              Center(
                child: TextButton.icon(
                  onPressed: onAddNew,
                  icon: const Icon(Icons.add, color: Colors.orange),
                  label: Text(
                    addNewText!,
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
