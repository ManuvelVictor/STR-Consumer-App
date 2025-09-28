import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Home/banner_model.dart';
import '../../models/Home/food_item_model.dart';
import '../../models/Home/location_model.dart';
import '../../models/Home/restaurant_model.dart';
import '../../repositories/food_repository.dart';
import '../../services/location_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodRepository foodRepository;
  final LocationService locationService;

  HomeBloc({required this.foodRepository, required this.locationService})
    : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<UpdateFoodQuantity>(_onUpdateFoodQuantity);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());

      final results = await Future.wait([
        foodRepository.getBanners(),
        foodRepository.getFrequentOrders(),
        foodRepository.getRestaurants(),
        locationService.getCurrentLocation(),
      ]);

      emit(
        HomeLoaded(
          banners: results[0] as List<BannerModel>,
          frequentOrders: results[1] as List<FoodItemModel>,
          restaurants: results[2] as List<RestaurantModel>,
          currentLocation: results[3] as LocationModel,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onUpdateFoodQuantity(
    UpdateFoodQuantity event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedItems = currentState.frequentOrders.map((item) {
        if (item.id == event.foodId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(frequentOrders: updatedItems));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedItems = currentState.frequentOrders.map((item) {
        if (item.id == event.foodId) {
          return item.copyWith(quantity: 1);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(frequentOrders: updatedItems));
    }
  }
}
