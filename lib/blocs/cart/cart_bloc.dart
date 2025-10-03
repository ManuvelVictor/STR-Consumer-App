import 'dart:async';
import '../../models/RegularOrders/Cart/cart_note_model.dart';
import '../../models/RegularOrders/Cart/coupon_model.dart';
import '../../models/RegularOrders/Cart/delivery_address_model.dart';
import '../../models/RegularOrders/Cart/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc {
  final _stateController = StreamController<CartState>.broadcast();

  Stream<CartState> get state => _stateController.stream;

  CartState _currentState = CartState(
    deliveryAddress: DeliveryAddressModel(
      address: '123, Gandhipuram Main Road, Coimbatore, Ta...',
      phone: '+91 9530295829',
    ),
  );

  CartBloc() {
    _loadMockData();
  }

  void _loadMockData() {
    _currentState = _currentState.copyWith(
      products: [
        ProductModel(
          id: '1',
          name: 'Shewan paneer rice',
          price: 90,
          quantity: 1,
        ),
        ProductModel(
          id: '2',
          name: 'Shewan paneer noodles',
          price: 90,
          quantity: 2,
        ),
        ProductModel(
          id: '3',
          name: 'Tomato rice',
          price: 70,
          quantity: 1,
        ),
      ],
      notes: [
        CartNoteModel(
          id: '1',
          text: 'Add more spice in tomato rice',
        ),
      ],
      appliedCoupon: CouponModel(code: 'FLAT80', discount: 80),
    );
    _emitState();
  }

  void handleEvent(CartEvent event) {
    if (event is LoadCartEvent) {
      _loadMockData();
    } else if (event is IncrementQuantityEvent) {
      _incrementQuantity(event.productId);
    } else if (event is DecrementQuantityEvent) {
      _decrementQuantity(event.productId);
    } else if (event is AddNoteEvent) {
      _addNote(event.note);
    } else if (event is DeleteNoteEvent) {
      _deleteNote(event.noteId);
    } else if (event is ApplyCouponEvent) {
      _applyCoupon(event.couponCode);
    } else if (event is RemoveCouponEvent) {
      _removeCoupon();
    } else if (event is UpdateDeliveryAddressEvent) {
      _updateDeliveryAddress(event.address);
    } else if (event is PlaceOrderEvent) {
      _placeOrder();
    }
  }

  void _incrementQuantity(String productId) {
    final updatedProducts = _currentState.products.map((p) {
      if (p.id == productId) {
        return p.copyWith(quantity: p.quantity + 1);
      }
      return p;
    }).toList();

    _currentState = _currentState.copyWith(products: updatedProducts);
    _emitState();
  }

  void _decrementQuantity(String productId) {
    final updatedProducts = _currentState.products.map((p) {
      if (p.id == productId && p.quantity > 1) {
        return p.copyWith(quantity: p.quantity - 1);
      }
      return p;
    }).toList();

    _currentState = _currentState.copyWith(products: updatedProducts);
    _emitState();
  }

  void _addNote(String note) {
    final newNote = CartNoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: note,
    );
    final updatedNotes = [..._currentState.notes, newNote];
    _currentState = _currentState.copyWith(notes: updatedNotes);
    _emitState();
  }

  void _deleteNote(String noteId) {
    final updatedNotes = _currentState.notes
        .where((n) => n.id != noteId)
        .toList();
    _currentState = _currentState.copyWith(notes: updatedNotes);
    _emitState();
  }

  void _applyCoupon(String couponCode) {
    if (couponCode.toUpperCase() == 'FLAT80') {
      _currentState = _currentState.copyWith(
        appliedCoupon: CouponModel(
          code: couponCode.toUpperCase(),
          discount: 80,
        ),
        clearError: true,
      );
    } else if (couponCode.toUpperCase() == 'SAVE50') {
      _currentState = _currentState.copyWith(
        appliedCoupon: CouponModel(
          code: couponCode.toUpperCase(),
          discount: 50,
        ),
        clearError: true,
      );
    } else {
      _currentState = _currentState.copyWith(
        errorMessage: 'Invalid coupon code',
      );
    }
    _emitState();
  }

  void _removeCoupon() {
    _currentState = _currentState.copyWith(clearCoupon: true);
    _emitState();
  }

  void _updateDeliveryAddress(DeliveryAddressModel address) {
    _currentState = _currentState.copyWith(deliveryAddress: address);
    _emitState();
  }

  void _placeOrder() {
    _currentState = _currentState.copyWith(isLoading: true);
    _emitState();

    Future.delayed(const Duration(seconds: 2), () {
      _currentState = _currentState.copyWith(
        isLoading: false,
        clearError: true,
      );
      _emitState();
    });
  }

  void _emitState() {
    _stateController.add(_currentState);
  }

  CartState get currentState => _currentState;

  void dispose() {
    _stateController.close();
  }
}