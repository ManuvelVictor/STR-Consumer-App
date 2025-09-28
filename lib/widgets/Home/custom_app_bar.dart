import 'dart:ui';

import 'package:flutter/material.dart';
import '../../models/Home/location_model.dart';

class CustomAppBar extends StatelessWidget {
  final bool showOnlySearch;
  final LocationModel location;

  const CustomAppBar({
    super.key,
    required this.showOnlySearch,
    required this.location,
  });

  Widget _buildAnimatedSearchBar(double t) {
    double height = lerpDouble(44, 40, t)!;
    double horizontal = lerpDouble(0, 8, t)!;
    double vertical = lerpDouble(0, 4, t)!;

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'What are you craving?',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey),
          suffixIcon: Icon(Icons.mic, size: 20, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange[400],
      elevation: 0,
      pinned: true,
      expandedHeight: 120,
      collapsedHeight: 60,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      title: showOnlySearch ? _buildAnimatedSearchBar(0.0) : null,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = 120.0;
          final minHeight = 60.0;
          final currentHeight = constraints.maxHeight;
          double t = (1 - (currentHeight - minHeight) / (maxHeight - minHeight))
              .clamp(0.0, 1.0);
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            background: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: 1 - t,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.black),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.label,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    location.address,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAnimatedSearchBar(t),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
