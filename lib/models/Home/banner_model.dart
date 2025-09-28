import 'dart:ui';

class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color backgroundColor;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.backgroundColor,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      backgroundColor: Color(json['backgroundColor']),
    );
  }
}