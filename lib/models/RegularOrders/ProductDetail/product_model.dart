class ProductModel {
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final double rating;
  final int ratingCount;

  ProductModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.rating,
    required this.ratingCount,
  });
}
