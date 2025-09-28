import 'package:flutter/material.dart';
import '../../models/Home/restaurant_model.dart';
import 'restaurant_card.dart';

class RestaurantSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantSection({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return RestaurantCard(restaurant: restaurants[index]);
        },
        childCount: restaurants.length,
      ),
    );
  }
}