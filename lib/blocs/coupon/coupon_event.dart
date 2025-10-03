import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCoupons extends CouponEvent {}
class ApplyCoupon extends CouponEvent {
  final String code;

  ApplyCoupon(this.code);

  @override
  List<Object> get props => [code];
}
