import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:str_customer_app/screens/CustomerScreens/home_screen.dart';
import 'package:str_customer_app/screens/OnboardingScreens/onboarding_screen.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/home/home_event.dart';
import 'repositories/food_repository.dart';
import 'services/location_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FoodRepository>(
          create: (context) => FoodRepository(),
        ),
        RepositoryProvider<LocationService>(
          create: (context) => LocationService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              foodRepository: context.read<FoodRepository>(),
              locationService: context.read<LocationService>(),
            )..add(LoadHomeData()),
          ),
        ],
        child: MaterialApp(
          title: 'Food Delivery App',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          home: OnboardingScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
