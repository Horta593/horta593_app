import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/pay_model.dart';

// Define your events
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentInitialEvent extends PaymentEvent {}

class InitializePaymentEvent extends PaymentEvent {
  final List<CartItem> shoppingCart;
  double subTotal;
  double total;

  InitializePaymentEvent(
      {required this.shoppingCart,
      required this.subTotal,
      required this.total});

  @override
  List<Object?> get props => [shoppingCart];
}

class ConfirmPaymentEvent extends PaymentEvent {
  final String paymentId;

  const ConfirmPaymentEvent({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}

class CancelPaymentEvent extends PaymentEvent {}

class RetryPaymentEvent extends PaymentEvent {}

class UpdateShoppingCartEvent extends PaymentEvent {
  final List<CartItem> newShoppingCart;

  const UpdateShoppingCartEvent({required this.newShoppingCart});

  @override
  List<Object?> get props => [newShoppingCart];
}


// part of 'payment_bloc.dart';

// abstract class PaymentEvent extends Equatable {
//   // const PaymentEvent();
//   @override
//   List<Object> get props => [];
// }

// class LoadPayment extends PaymentEvent {}

// class UpdatePayment extends PaymentEvent {
//   final Pay updatedPay;

//   UpdatePayment({required this.updatedPay});

//   @override
//   List<Object> get props => [updatedPay];
// }

// class MakePayment extends PaymentEvent {
//   final Pay pay;
//   MakePayment({required this.pay});
// }
