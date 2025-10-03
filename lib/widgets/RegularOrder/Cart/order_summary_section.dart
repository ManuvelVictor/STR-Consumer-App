import 'package:flutter/material.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../blocs/cart/cart_event.dart';
import '../../../blocs/cart/cart_state.dart';
import '../../../utils/app_styles.dart';
import 'cart_item_widget.dart';
import 'notes_section_widget.dart';

class OrderSummarySection extends StatelessWidget {
  final CartState state;
  final CartBloc cartBloc;
  final VoidCallback onAddMoreItems;
  final VoidCallback onAddNote;

  const OrderSummarySection({
    super.key,
    required this.state,
    required this.cartBloc,
    required this.onAddMoreItems,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppStyles.headlineVerySmall,
          ),
          const SizedBox(height: 10),
          _buildCartItems(),
          const SizedBox(height: 16),
          _buildActionButtons(),
          NotesSectionWidget(
            notes: state.notes,
            onDeleteNote: (noteId) {
              cartBloc.handleEvent(DeleteNoteEvent(noteId));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      children: List.generate(state.products.length, (index) {
        final product = state.products[index];
        final isLast = index == state.products.length - 1;

        return CartItemWidget(
          product: product,
          onIncrement: () {
            cartBloc.handleEvent(IncrementQuantityEvent(product.id));
          },
          onDecrement: () {
            cartBloc.handleEvent(DecrementQuantityEvent(product.id));
          },
          isLast: isLast,
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add,
            text: 'Add more items',
            onTap: onAddMoreItems,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.note_add_outlined,
            text: 'Add a note',
            onTap: onAddNote,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF757575)),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}