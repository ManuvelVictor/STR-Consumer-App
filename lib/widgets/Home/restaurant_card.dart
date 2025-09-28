import 'package:flutter/material.dart';
import '../../models/Home/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.delivery_dining, color: Colors.orange[800]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (restaurant.isDelivering)
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Arriving in ${restaurant.deliveryTime}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    'Delivery in ${restaurant.deliveryTime}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          Icon(Icons.location_on, color: Colors.orange),
        ],
      ),
    );
  }
}
