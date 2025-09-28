class FoodItemModel {
  final String id;
  final String name;
  final String restaurant;
  final double price;
  final double rating;
  final String imageUrl;
  final int quantity;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.quantity = 0,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'],
      name: json['name'],
      restaurant: json['restaurant'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      imageUrl: json['imageUrl'],
      quantity: json['quantity'] ?? 0,
    );
  }

  FoodItemModel copyWith({
    String? id,
    String? name,
    String? restaurant,
    double? price,
    double? rating,
    String? imageUrl,
    int? quantity,
  }) {
    return FoodItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      restaurant: restaurant ?? this.restaurant,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}