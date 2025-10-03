import '../../models/RegularOrders/ProductDetail/product_model.dart';

class ProductDetailsState {
  final ProductModel? product;
  final int quantity;

  ProductDetailsState({this.product, this.quantity = 1});

  double get totalPrice => (product?.price ?? 0) * quantity;

  ProductDetailsState copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
