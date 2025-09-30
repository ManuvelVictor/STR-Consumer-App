import 'package:flutter/material.dart';

class SmallPanAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<Offset> position;

  const SmallPanAnimation({
    super.key,
    required this.controller,
    required this.opacity,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: size.width * 0.25,
      top: size.height * 0.1,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Opacity(
            opacity: opacity.value,
            child: SlideTransition(
              position: position,
              child: Image.asset(
                'assets/images/small_pans.png',
                width: size.width,
                height: size.width,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
