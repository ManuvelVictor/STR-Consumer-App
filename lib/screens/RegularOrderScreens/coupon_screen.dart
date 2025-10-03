import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:str_customer_app/utils/app_styles.dart';
import '../../blocs/coupon/coupon_bloc.dart';
import '../../blocs/coupon/coupon_event.dart';
import '../../blocs/coupon/coupon_state.dart';
import '../../widgets/RegularOrder/Coupon/coupon_list_widget.dart';
import '../../widgets/RegularOrder/ProductDetail/custom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coupon Test',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const CouponScreen(),
    );
  }
}

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F4),
      appBar: CustomSmallAppBar(
        title: "Coupons",
        onBackPressed: () {
          context.pop();
        },
      ),
      body: BlocProvider(
        create: (_) => CouponBloc()..add(LoadCoupons()),
        child: BlocBuilder<CouponBloc, CouponState>(
          builder: (context, state) {
            if (state is CouponLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CouponLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Best offers", style: AppStyles.headlineSmall),
                  ),
                  Expanded(
                    child: CouponListWidget(
                      coupons: state.coupons,
                      appliedCoupon: state.appliedCoupon,
                      onApply: (code) {
                        context.read<CouponBloc>().add(ApplyCoupon(code));
                      },
                    ),
                  ),
                ],
              );
            } else if (state is CouponError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
