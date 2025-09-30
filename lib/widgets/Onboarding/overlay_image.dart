import 'package:flutter/material.dart';

class OverlayImage extends StatelessWidget {
  final String image;

  const OverlayImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
