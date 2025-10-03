import 'package:flutter/material.dart';
import '../../models/Home/banner_model.dart';
import 'banner_item.dart';

class BannerSection extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerSection({super.key, required this.banners});

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.all(16),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: BannerItem(imagePath: widget.banners[index].image),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.banners.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 10 : 6,
                height: isActive ? 10 : 6,
                decoration: BoxDecoration(
                  color: isActive ? Colors.orange : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}