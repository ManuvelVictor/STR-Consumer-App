class ProductModel {
  final String id;
  final String name;
  final double price;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => price * quantity;
}