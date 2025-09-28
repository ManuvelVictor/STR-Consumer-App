abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class UpdateFoodQuantity extends HomeEvent {
  final String foodId;
  final int quantity;

  UpdateFoodQuantity({required this.foodId, required this.quantity});
}

class AddToCart extends HomeEvent {
  final String foodId;

  AddToCart({required this.foodId});
}
