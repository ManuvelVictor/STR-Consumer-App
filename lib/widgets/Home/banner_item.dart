import 'package:flutter/material.dart';

class BannerItem extends StatelessWidget {
  final String imagePath;

  const BannerItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
