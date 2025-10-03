import 'package:equatable/equatable.dart';
import '../../models/RegularOrders/Coupon/coupon_model.dart';

abstract class CouponState extends Equatable {
  @override
  List<Object> get props => [];
}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponLoaded extends CouponState {
  final List<CouponModel> coupons;
  final String? appliedCoupon;

  CouponLoaded({required this.coupons, this.appliedCoupon});

  @override
  List<Object> get props => [coupons, appliedCoupon ?? ""];
}

class CouponError extends CouponState {
  final String message;
  CouponError(this.message);

  @override
  List<Object> get props => [message];
}
