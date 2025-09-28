import 'package:flutter/material.dart';
import '../../models/Home/banner_model.dart';
import 'banner_item.dart';

class BannerSection extends StatelessWidget {
  final List<BannerModel> banners;

  const BannerSection({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 180,
        margin: EdgeInsets.all(16),
        child: PageView.builder(
          itemCount: banners.length,
          itemBuilder: (context, index) {
            return BannerItem(banner: banners[index]);
          },
        ),
      ),
    );
  }
}