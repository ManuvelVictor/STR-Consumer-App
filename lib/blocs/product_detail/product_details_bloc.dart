import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/RegularOrders/ProductDetail/product_model.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsState()) {
    on<LoadProduct>(_onLoadProduct);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  void _onLoadProduct(LoadProduct event, Emitter<ProductDetailsState> emit) {
    final mockProduct = ProductModel(
      name: "Schezwan  paneer rice",
      imageUrl: "assets/images/schezwan_panner_rice.png",
      price: 332,
      description:
          "Indulge in a flavorful blend of aromatic rice and marinated paneer, cooked with our special Schezwan spices. Perfectly balanced with herbs and a hint of tangy goodness, this dish is both satisfying and delicious.",
      rating: 4.5,
      ratingCount: 15,
    );
    emit(ProductDetailsState(product: mockProduct, quantity: 1));
  }

  void _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<ProductDetailsState> emit,
  ) {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}
