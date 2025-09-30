import 'package:flutter/material.dart';

class LocationBackground extends StatelessWidget {
  final Widget child;

  const LocationBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/location_bg.png",
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
