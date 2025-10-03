import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/RegularOrders/Coupon/coupon_model.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    on<LoadCoupons>(_onLoadCoupons);
    on<ApplyCoupon>(_onApplyCoupon);
  }

  void _onLoadCoupons(LoadCoupons event, Emitter<CouponState> emit) {
    emit(CouponLoading());

    final coupons = [
      CouponModel(
        code: "FLAT80",
        discountText: "Save ₹ 80",
        description: "Upto ₹ 80 offer on order worth ₹ 299 or more",
        isApplicable: true,
      ),
      CouponModel(
        code: "FLAT120",
        discountText: "Save upto 20%",
        description: "Upto 20% offer on order worth ₹ 299 or more",
        isApplicable: true,
      ),
      CouponModel(
        code: "WELO10",
        discountText: "Save ₹ 60",
        description: "Upto ₹ 60 offer on order worth ₹ 299 or more",
        isApplicable: false,
      ),
    ];

    emit(CouponLoaded(coupons: coupons));
  }

  void _onApplyCoupon(ApplyCoupon event, Emitter<CouponState> emit) {
    if (state is CouponLoaded) {
      final currentState = state as CouponLoaded;
      emit(CouponLoaded(coupons: currentState.coupons, appliedCoupon: event.code));
    }
  }
}
