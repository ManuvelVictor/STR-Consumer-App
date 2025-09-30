import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.location_on, size: 40, color: AppColors.primary),
    );
  }
}
