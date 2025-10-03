import 'PaymentType.dart';

class PaymentMethodModel {
  final String id;
  final String title;
  final String? subtitle;
  final String icon;
  final PaymentType type;

  PaymentMethodModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.type,
  });
}
