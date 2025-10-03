import '../../models/RegularOrders/Cart/cart_note_model.dart';
import '../../models/RegularOrders/Cart/coupon_model.dart';
import '../../models/RegularOrders/Cart/delivery_address_model.dart';
import '../../models/RegularOrders/Cart/product_model.dart';

class CartState {
  final List<ProductModel> products;
  final List<CartNoteModel> notes;
  final CouponModel? appliedCoupon;
  final DeliveryAddressModel deliveryAddress;
  final bool isLoading;
  final String? errorMessage;

  CartState({
    this.products = const [],
    this.notes = const [],
    this.appliedCoupon,
    required this.deliveryAddress,
    this.isLoading = false,
    this.errorMessage,
  });

  double get subtotal => products.fold(0, (sum, item) => sum + item.totalPrice);

  double get discount => appliedCoupon?.discount ?? 0;

  double get total => subtotal - discount;

  CartState copyWith({
    List<ProductModel>? products,
    List<CartNoteModel>? notes,
    CouponModel? appliedCoupon,
    bool clearCoupon = false,
    DeliveryAddressModel? deliveryAddress,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CartState(
      products: products ?? this.products,
      notes: notes ?? this.notes,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}