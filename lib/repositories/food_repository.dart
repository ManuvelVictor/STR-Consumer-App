import '../models/Home/banner_model.dart';
import '../models/Home/food_item_model.dart';
import '../models/Home/restaurant_model.dart';

class FoodRepository {
  Future<List<BannerModel>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      BannerModel(image: "assets/images/banner.png"),
      BannerModel(image: "assets/images/banner.png"),
      BannerModel(image: "assets/images/banner.png"),
    ];
  }

  Future<List<FoodItemModel>> getFrequentOrders() async {
    await Future.delayed(Duration(milliseconds: 300));
    return [
      FoodItemModel(
        id: '1',
        name: 'Schezwan paneer noodles',
        restaurant: 'STR',
        price: 332,
        rating: 4.5,
        imageUrl: 'assets/noodles.jpg',
        quantity: 1,
      ),
      FoodItemModel(
        id: '2',
        name: 'Schezwan paneer rice',
        restaurant: 'STR',
        price: 332,
        rating: 4.5,
        imageUrl: 'assets/rice.jpg',
      ),
    ];
  }

  Future<List<RestaurantModel>> getRestaurants() async {
    await Future.delayed(Duration(milliseconds: 200));
    return [
      RestaurantModel(
        id: '1',
        name: 'STR',
        deliveryTime: '24 min',
        imageUrl: 'assets/restaurant1.jpg',
        isDelivering: true,
      ),
      RestaurantModel(
        id: '2',
        name: 'Pizza Palace',
        deliveryTime: '30 min',
        imageUrl: 'assets/restaurant2.jpg',
      ),
    ];
  }
}
