import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:str_customer_app/nav/routes.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import '../../widgets/Onboarding/bottom_controls.dart';
import '../../widgets/Onboarding/knife_animation.dart';
import '../../widgets/Onboarding/overlay_image.dart';
import '../../widgets/Onboarding/pan_animation.dart';
import '../../widgets/Onboarding/small_pan_animation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenAnimationState createState() =>
      OnboardingScreenAnimationState();
}

class OnboardingScreenAnimationState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _smallPanController;
  late AnimationController _glowController;
  late AnimationController _knifeController;

  late Animation<double> _rotationAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _smallPanOpacity;
  late Animation<Offset> _smallPanPosition;
  late Animation<double> _glowOpacity;
  late Animation<Offset> _knifePosition;

  int _currentStep = 0;

  final List<String> _overlays = [
    'assets/images/onboarding_overlay_1.png',
    'assets/images/onboarding_overlay_2.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _smallPanController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _knifeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _setupAnimation();
    _setupSmallPanAnimation();
    _setupGlowAnimation();
    _setupKnifeAnimation();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentStep > 0) _glowController.forward();
        if (_currentStep == 1) _smallPanController.forward();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAllImages();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _controller.forward();
          if (_currentStep == 0) _knifeController.forward();
        }
      });
    });
  }

  void _setupAnimation() {
    if (_currentStep == 0) {
      _rotationAnimation = Tween<double>(
        begin: 3.14159,
        end: 0.0,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _positionAnimation = Tween<Offset>(
        begin: const Offset(1.5, 0.0),
        end: const Offset(0.35, 0.0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    } else {
      _rotationAnimation = Tween<double>(
        begin: 0.0,
        end: -4.222,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _positionAnimation = Tween<Offset>(
        begin: const Offset(0.35, 0.0),
        end: const Offset(-0.35, 0.0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    }
  }

  void _setupSmallPanAnimation() {
    _smallPanOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _smallPanController, curve: Curves.easeInOut),
    );
    _smallPanPosition =
        Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(parent: _smallPanController, curve: Curves.easeInOut),
        );
  }

  void _setupGlowAnimation() {
    _glowOpacity = Tween<double>(
      begin: 0.0,
      end: 0.6,
    ).animate(CurvedAnimation(parent: _glowController, curve: Curves.easeIn));
  }

  void _setupKnifeAnimation() {
    _knifePosition =
        Tween<Offset>(
          begin: const Offset(0.0, 1.2),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(parent: _knifeController, curve: Curves.easeInOut),
        );
  }

  void _precacheAllImages() {
    for (var overlay in _overlays) {
      precacheImage(AssetImage(overlay), context);
    }
    precacheImage(const AssetImage('assets/images/pan.png'), context);
    precacheImage(const AssetImage('assets/images/small_pan.png'), context);
    precacheImage(const AssetImage('assets/images/knife.png'), context);
  }

  void _onSkip() => context.go(AppRoutes.login);

  void _onNext() {
    if (_currentStep < _overlays.length - 1) {
      setState(() {
        _currentStep++;
        _setupAnimation();
        _smallPanController.reset();
        _glowController.reset();
        _controller.forward(from: 0.0);
        if (_currentStep == 1) _knifeController.reverse();
      });
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _smallPanController.dispose();
    _glowController.dispose();
    _knifeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          PanAnimation(
            controller: _controller,
            glowController: _glowController,
            rotationAnimation: _rotationAnimation,
            positionAnimation: _positionAnimation,
          ),
          KnifeAnimation(
            controller: _knifeController,
            knifePosition: _knifePosition,
          ),
          if (_currentStep == 1)
            SmallPanAnimation(
              controller: _smallPanController,
              opacity: _smallPanOpacity,
              position: _smallPanPosition,
            ),
          OverlayImage(image: _overlays[_currentStep]),
          BottomControls(onSkip: _onSkip, onNext: _onNext),
        ],
      ),
    );
  }
}
