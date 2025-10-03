import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/product_detail/product_details_bloc.dart';
import '../../blocs/product_detail/product_details_event.dart';
import '../../blocs/product_detail/product_details_state.dart';
import '../../widgets/RegularOrder/ProductDetail/custom_app_bar.dart';
import '../../widgets/RegularOrder/ProductDetail/product_image.dart';
import '../../widgets/RegularOrder/ProductDetail/product_info.dart';
import '../../widgets/RegularOrder/ProductDetail/quantity_selector.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsBloc()..add(LoadProduct()),
      child: Scaffold(
        appBar: CustomSmallAppBar(
          title: "Product Details",
          onBackPressed: () => context.pop(),
        ),
        body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state.product == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                ProductImage(imageUrl: state.product!.imageUrl),
                const SizedBox(height: 16),
                ProductInfo(product: state.product!),
                const Spacer(),
                QuantitySelector(
                  quantity: state.quantity,
                  onIncrease: () => context.read<ProductDetailsBloc>().add(
                    IncreaseQuantity(),
                  ),
                  onDecrease: () => context.read<ProductDetailsBloc>().add(
                    DecreaseQuantity(),
                  ),
                  totalPrice: state.totalPrice,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
