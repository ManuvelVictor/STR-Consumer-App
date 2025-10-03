import '../../models/RegularOrders/Payment/payment_method_model.dart';

abstract class PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentMethodModel> methods;
  final String? selectedMethodId;
  final double amount;

  PaymentLoaded({
    required this.methods,
    this.selectedMethodId,
    required this.amount,
  });
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}
