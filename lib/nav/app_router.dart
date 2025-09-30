import 'package:go_router/go_router.dart';
import 'package:str_customer_app/nav/routes.dart';
import '../screens/AuthScreens/login_screen.dart';
import '../screens/AuthScreens/signup_screen.dart';
import '../screens/OnboardingScreens/onboarding_screen.dart';
import '../screens/CustomerScreens/home_screen.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter(bool isLoggedIn) {
    router = GoRouter(
      initialLocation: isLoggedIn ? AppRoutes.home : AppRoutes.onboarding,
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }
}
