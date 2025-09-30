import 'package:flutter/material.dart';

class KnifeAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<Offset> knifePosition;

  const KnifeAnimation({
    super.key,
    required this.controller,
    required this.knifePosition,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.value == 0.0) return const SizedBox();
        return Positioned(
          bottom: size.height * 0.3,
          left: size.width * 0.25,
          child: SlideTransition(
            position: knifePosition,
            child: FadeTransition(
              opacity: controller,
              child: Image.asset(
                'assets/images/knife.png',
                width: size.width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
