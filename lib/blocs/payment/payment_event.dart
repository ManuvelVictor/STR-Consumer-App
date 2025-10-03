abstract class PaymentEvent {}

class LoadPaymentMethods extends PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  final String methodId;

  SelectPaymentMethod(this.methodId);
}
