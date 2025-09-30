import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PanAnimation extends StatelessWidget {
  final AnimationController controller;
  final AnimationController glowController;
  final Animation<double> rotationAnimation;
  final Animation<Offset> positionAnimation;

  const PanAnimation({
    super.key,
    required this.controller,
    required this.glowController,
    required this.rotationAnimation,
    required this.positionAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([controller, glowController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            positionAnimation.value.dx * size.width,
            positionAnimation.value.dy * size.height,
          ),
          child: Transform.rotate(
            angle: rotationAnimation.value,
            child: Transform.scale(
              scale: 1.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (glowController.value > 0)
                    Opacity(
                      opacity: glowController.value,
                      child: Container(
                        width: size.width * 1.5,
                        height: size.height * 0.65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryLight,
                              blurRadius: 80,
                              spreadRadius: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Image.asset(
                    'assets/images/pan.png',
                    width: size.width * 1.5,
                    height: size.height * 0.65,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
