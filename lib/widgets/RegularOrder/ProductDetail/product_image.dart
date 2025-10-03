import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        // For now, use local asset instead of network
        child: Image.asset(
          imageUrl,
          height: 220,
          fit: BoxFit.cover,
        ),
        // child: Image.network(imageUrl, height: 220, fit: BoxFit.cover), // original
      ),
    );
  }
}
