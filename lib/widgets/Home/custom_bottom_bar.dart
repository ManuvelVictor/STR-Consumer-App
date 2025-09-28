import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double animation;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final barHeight = lerpDouble(0, 80, animation)!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: barHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home, "Home", 0),
          const SizedBox(width: 60),
          _buildBottomNavItem(Icons.restaurant_menu, "Catering", 2),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.orange : Colors.grey,
              size: lerpDouble(20, 24, animation)!,
            ),
            const SizedBox(height: 4),
            AnimatedOpacity(
              opacity: animation,
              duration: const Duration(milliseconds: 300),
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.orange : Colors.grey,
                  fontSize: lerpDouble(0, 12, animation),
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}