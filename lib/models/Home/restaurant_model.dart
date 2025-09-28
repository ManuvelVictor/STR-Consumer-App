class RestaurantModel {
  final String id;
  final String name;
  final String deliveryTime;
  final String imageUrl;
  final bool isDelivering;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.deliveryTime,
    required this.imageUrl,
    this.isDelivering = false,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      deliveryTime: json['deliveryTime'],
      imageUrl: json['imageUrl'],
      isDelivering: json['isDelivering'] ?? false,
    );
  }
}