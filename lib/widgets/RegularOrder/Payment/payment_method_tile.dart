import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../../models/RegularOrders/Payment/payment_method_model.dart';

class PaymentMethodTile extends StatelessWidget {
  final PaymentMethodModel method;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          children: [
            Image.asset(
              method.icon,
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                method.title,
                style: AppStyles.bodyMedium,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              )
            else
              const Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
