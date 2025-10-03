import '../../models/RegularOrders/Cart/delivery_address_model.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class IncrementQuantityEvent extends CartEvent {
  final String productId;

  IncrementQuantityEvent(this.productId);
}

class DecrementQuantityEvent extends CartEvent {
  final String productId;

  DecrementQuantityEvent(this.productId);
}

class AddNoteEvent extends CartEvent {
  final String note;

  AddNoteEvent(this.note);
}

class DeleteNoteEvent extends CartEvent {
  final String noteId;

  DeleteNoteEvent(this.noteId);
}

class ApplyCouponEvent extends CartEvent {
  final String couponCode;

  ApplyCouponEvent(this.couponCode);
}

class RemoveCouponEvent extends CartEvent {}

class UpdateDeliveryAddressEvent extends CartEvent {
  final DeliveryAddressModel address;

  UpdateDeliveryAddressEvent(this.address);
}

class PlaceOrderEvent extends CartEvent {}
