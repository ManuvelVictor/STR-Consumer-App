import 'package:go_router/go_router.dart';
import 'package:str_customer_app/nav/routes.dart';
import 'package:str_customer_app/screens/OnboardingScreens/location_access_screen.dart';
import 'package:str_customer_app/screens/OnboardingScreens/otp_verification_screen.dart';
import '../screens/OnboardingScreens/AuthScreens/login_screen.dart';
import '../screens/OnboardingScreens/AuthScreens/signup_screen.dart';
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
        GoRoute(
          path: AppRoutes.otp,
          builder: (context, state) {
            final phoneNumber = state.extra as String;
            return OtpVerificationScreen(phoneNumber: phoneNumber);
          },
        ),
        GoRoute(
          path: AppRoutes.locationAccess,
          builder: (context, state) => const LocationAccessScreen(),
        ),
      ],
    );
  }
}
