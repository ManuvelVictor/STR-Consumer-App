import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/home/home_event.dart';
import 'data/local/shared_preferences.dart';
import 'nav/app_router.dart';
import 'repositories/food_repository.dart';
import 'services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await AuthStorage.isLoggedIn();

  final appRouter = AppRouter(isLoggedIn);

  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

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
        child: MaterialApp.router(
          title: 'STR',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          routerConfig: appRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
