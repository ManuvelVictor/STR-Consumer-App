import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_event.dart';
import '../../models/Home/food_item_model.dart';
import 'food_item_card.dart';

class FrequentOrdersSection extends StatelessWidget {
  final List<FoodItemModel> orders;

  const FrequentOrdersSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Frequent orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return FoodItemCard(
                  foodItem: orders[index],
                  onQuantityChanged: (quantity) {
                    context.read<HomeBloc>().add(
                      UpdateFoodQuantity(
                        foodId: orders[index].id,
                        quantity: quantity,
                      ),
                    );
                  },
                  onAddToCart: () {
                    context.read<HomeBloc>().add(
                      AddToCart(foodId: orders[index].id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
