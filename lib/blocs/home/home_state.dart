import '../../models/Home/banner_model.dart';
import '../../models/Home/food_item_model.dart';
import '../../models/Home/location_model.dart';
import '../../models/Home/restaurant_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BannerModel> banners;
  final List<FoodItemModel> frequentOrders;
  final List<RestaurantModel> restaurants;
  final LocationModel currentLocation;

  HomeLoaded({
    required this.banners,
    required this.frequentOrders,
    required this.restaurants,
    required this.currentLocation,
  });

  HomeLoaded copyWith({
    List<BannerModel>? banners,
    List<FoodItemModel>? frequentOrders,
    List<RestaurantModel>? restaurants,
    LocationModel? currentLocation,
  }) {
    return HomeLoaded(
      banners: banners ?? this.banners,
      frequentOrders: frequentOrders ?? this.frequentOrders,
      restaurants: restaurants ?? this.restaurants,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
