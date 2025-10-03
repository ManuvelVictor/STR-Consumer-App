import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/RegularOrders/Payment/PaymentType.dart';
import '../../models/RegularOrders/Payment/payment_method_model.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethods>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        PaymentLoaded(
          methods: [
            PaymentMethodModel(
              id: "card1",
              title: "HDFC Bank",
              subtitle: "*** 5847",
              icon: "assets/images/hdfc.png",
              type: PaymentType.card,
            ),
            PaymentMethodModel(
              id: "gpay",
              title: "Google Pay",
              icon: "assets/images/gpay.png",
              type: PaymentType.upi,
            ),
            PaymentMethodModel(
              id: "phonepe",
              title: "PhonePe",
              icon: "assets/images/phonepe.png",
              type: PaymentType.upi,
            ),
            PaymentMethodModel(
              id: "amazon",
              title: "Amazon Pay",
              icon: "assets/images/amazon_pay.png",
              type: PaymentType.upi,
            ),
            PaymentMethodModel(
              id: "upi",
              title: "938499849@ybl",
              icon: "assets/images/upi.png",
              type: PaymentType.upi,
            ),
            PaymentMethodModel(
              id: "cod",
              title: "Cash on Delivery",
              icon: "assets/images/cod.png",
              type: PaymentType.cod,
            ),
          ],
          selectedMethodId: "phonepe",
          amount: 415.52,
        ),
      );
    });

    on<SelectPaymentMethod>((event, emit) {
      if (state is PaymentLoaded) {
        final current = state as PaymentLoaded;
        emit(
          PaymentLoaded(
            methods: current.methods,
            selectedMethodId: event.methodId,
            amount: current.amount,
          ),
        );
      }
    });
  }
}
