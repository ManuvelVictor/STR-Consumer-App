import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../widgets/RegularOrder/Cart/bottom_order_bar.dart';
import '../../widgets/RegularOrder/Cart/cart_dialog.dart';
import '../../widgets/RegularOrder/Cart/coupon_section_widget.dart';
import '../../widgets/RegularOrder/Cart/delivery_section_widget.dart';
import '../../widgets/RegularOrder/Cart/order_summary_section.dart';
import '../../widgets/RegularOrder/ProductDetail/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _cartBloc = CartBloc();
    _cartBloc.handleEvent(LoadCartEvent());
  }

  @override
  void dispose() {
    _cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F4),
      appBar: CustomSmallAppBar(
        title: 'Cart',
        onBackPressed: () => context.pop(),
      ),
      body: StreamBuilder<CartState>(
        stream: _cartBloc.state,
        initialData: _cartBloc.currentState,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final state = snapshot.data!;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    OrderSummarySection(
                      state: state,
                      cartBloc: _cartBloc,
                      onAddMoreItems: _navigateToMenu,
                      onAddNote: () => _showAddNoteDialog(context),
                    ),
                    const SizedBox(height: 16),
                    CouponSectionWidget(
                      appliedCoupon: state.appliedCoupon,
                      onRemoveCoupon: () {
                        _cartBloc.handleEvent(RemoveCouponEvent());
                      },
                      onEnterCode: () => _showEnterCouponDialog(context),
                      onViewAllCoupons: _navigateToCoupons,
                    ),
                    const SizedBox(height: 16),
                    DeliverySectionWidget(
                      deliveryAddress: state.deliveryAddress,
                      onEdit: () => _showEditAddressDialog(context, state),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              BottomOrderBar(
                total: state.total,
                onPlaceOrder: () {
                  _cartBloc.handleEvent(PlaceOrderEvent());
                },
              ),
              if (state.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _navigateToMenu() {
    // Navigate to menu screen
  }

  void _navigateToCoupons() {
    // Navigate to coupons screen
  }

  void _showAddNoteDialog(BuildContext context) {
    CartDialogs.showAddNoteDialog(
      context: context,
      onAddNote: (note) {
        _cartBloc.handleEvent(AddNoteEvent(note));
      },
    );
  }

  void _showEnterCouponDialog(BuildContext context) {
    CartDialogs.showEnterCouponDialog(
      context: context,
      onApplyCoupon: (couponCode) {
        _cartBloc.handleEvent(ApplyCouponEvent(couponCode));
      },
    );
  }

  void _showEditAddressDialog(BuildContext context, CartState state) {
    CartDialogs.showEditAddressDialog(
      context: context,
      currentAddress: state.deliveryAddress,
      onSaveAddress: (newAddress) {
        _cartBloc.handleEvent(UpdateDeliveryAddressEvent(newAddress));
      },
    );
  }
}