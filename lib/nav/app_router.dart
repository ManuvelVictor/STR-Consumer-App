import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
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
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return _buildSlideTransition(animation, child);
                },
          ),
        ),
        GoRoute(
          path: AppRoutes.login,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return _buildSlideTransition(animation, child);
                },
          ),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SignUpScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return _buildSlideTransition(animation, child);
                },
          ),
        ),
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return _buildFadeTransition(animation, child);
                },
          ),
        ),
        GoRoute(
          path: AppRoutes.otp,
          pageBuilder: (context, state) {
            final phoneNumber = state.extra as String;
            return CustomTransitionPage(
              key: state.pageKey,
              child: OtpVerificationScreen(phoneNumber: phoneNumber),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return _buildSlideTransition(
                      animation,
                      child,
                      begin: const Offset(1.0, 0.0),
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.locationAccess,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const LocationAccessScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return _buildScaleTransition(animation, child);
                },
          ),
        ),
      ],
    );
  }

  static Widget _buildSlideTransition(
    Animation<double> animation,
    Widget child, {
    Offset? begin,
  }) {
    const end = Offset.zero;
    final beginOffset = begin ?? const Offset(1.0, 0.0);

    final slideAnimation = Tween<Offset>(begin: beginOffset, end: end).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      ),
    );

    return SlideTransition(position: slideAnimation, child: child);
  }

  static Widget _buildFadeTransition(
    Animation<double> animation,
    Widget child,
  ) {
    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    return FadeTransition(opacity: fadeAnimation, child: child);
  }

  static Widget _buildScaleTransition(
    Animation<double> animation,
    Widget child,
  ) {
    final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack,
      ),
    );

    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: child),
    );
  }

  static Widget _buildSlideFromBottomTransition(
    Animation<double> animation,
    Widget child,
  ) {
    const end = Offset.zero;
    const begin = Offset(0.0, 1.0);

    final slideAnimation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      ),
    );

    return SlideTransition(position: slideAnimation, child: child);
  }
}
