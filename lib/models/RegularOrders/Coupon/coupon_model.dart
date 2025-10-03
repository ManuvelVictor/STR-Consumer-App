class CouponModel {
  final String code;
  final String description;
  final String discountText;
  final bool isApplicable;

  CouponModel({
    required this.code,
    required this.description,
    required this.discountText,
    required this.isApplicable,
  });
}
