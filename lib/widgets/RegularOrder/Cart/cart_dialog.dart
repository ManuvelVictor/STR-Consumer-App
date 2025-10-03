import 'package:flutter/material.dart';
import '../../../models/RegularOrders/Cart/delivery_address_model.dart';

class CartDialogs {
  static void showAddNoteDialog({
    required BuildContext context,
    required Function(String) onAddNote,
  }) {
    final TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a Note'),
        content: TextField(
          controller: noteController,
          decoration: const InputDecoration(
            hintText: 'Enter your note',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (noteController.text.isNotEmpty) {
                onAddNote(noteController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E42),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  static void showEnterCouponDialog({
    required BuildContext context,
    required Function(String) onApplyCoupon,
  }) {
    final TextEditingController couponController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Coupon Code'),
        content: TextField(
          controller: couponController,
          decoration: const InputDecoration(
            hintText: 'Enter coupon code',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.characters,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (couponController.text.isNotEmpty) {
                onApplyCoupon(couponController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E42),
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  static void showEditAddressDialog({
    required BuildContext context,
    required DeliveryAddressModel currentAddress,
    required Function(DeliveryAddressModel) onSaveAddress,
  }) {
    final TextEditingController addressController = TextEditingController(
      text: currentAddress.address,
    );
    final TextEditingController phoneController = TextEditingController(
      text: currentAddress.phone,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Delivery Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (addressController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                onSaveAddress(
                  DeliveryAddressModel(
                    address: addressController.text,
                    phone: phoneController.text,
                  ),
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E42),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}