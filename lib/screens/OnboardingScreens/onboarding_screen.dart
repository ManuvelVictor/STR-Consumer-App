import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';

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
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _smallPanOpacity;
  late Animation<Offset> _smallPanPosition;
  late Animation<double> _glowOpacity;
  late AnimationController _knifeController;
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
        if (_currentStep > 0) {
          _glowController.forward();
        }
        if (_currentStep == 1) {
          _smallPanController.forward();
        }
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

  void _precacheAllImages() {
    for (var overlay in _overlays) {
      precacheImage(AssetImage(overlay), context);
    }
    precacheImage(const AssetImage('assets/images/pan.png'), context);
    precacheImage(const AssetImage('assets/images/small_pan.png'), context);
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

  void _onSkip() {
    debugPrint("Skipped");
  }

  void _onNext() {
    if (_currentStep < _overlays.length - 1) {
      setState(() {
        _currentStep++;
        _setupAnimation();
        _smallPanController.reset();
        _glowController.reset();
        _controller.forward(from: 0.0);
        if (_currentStep == 1) {
          _knifeController.reverse();
        }
      });
    } else {
      debugPrint("Reached last step → Go to next screen");
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
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_controller, _glowController]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  _positionAnimation.value.dx * width,
                  _positionAnimation.value.dy * height,
                ),
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_glowOpacity.value > 0)
                          Opacity(
                            opacity: _glowOpacity.value,
                            child: Container(
                              width: width * 1.5,
                              height: height * 0.65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withValues(alpha: 0.4),
                                    blurRadius: 80,
                                    spreadRadius: 40,
                                  ),
                                  BoxShadow(
                                    color: Colors.yellow.withValues(alpha: 0.3),
                                    blurRadius: 60,
                                    spreadRadius: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          width: width * 1.5,
                          height: height * 0.65,
                          child: Image.asset(
                            'assets/images/pan.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _knifeController,
            builder: (context, child) {
              if (_knifeController.value == 0.0) return const SizedBox();
              return Positioned(
                bottom: height * 0.3,
                left: width * 0.25,
                child: SlideTransition(
                  position: _knifePosition,
                  child: FadeTransition(
                    opacity: _knifeController,
                    child: Image.asset(
                      'assets/images/knife.png',
                      width: width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          if (_currentStep == 1)
            Positioned(
              left: width * 0.25,
              top: height * 0.1,
              child: AnimatedBuilder(
                animation: _smallPanController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _smallPanOpacity.value,
                    child: SlideTransition(
                      position: _smallPanPosition,
                      child: Image.asset(
                        'assets/images/small_pans.png',
                        width: width,
                        height: width,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: height * 0.4,
              child: Image.asset(_overlays[_currentStep], fit: BoxFit.cover),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _onSkip,
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black87,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
