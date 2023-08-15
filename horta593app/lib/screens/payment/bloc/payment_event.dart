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

class InitializePayment extends PaymentEvent {
  final Pay pay;

  const InitializePayment({required this.pay});

  @override
  List<Object?> get props => [pay];
}

class ConfirmPayment extends PaymentEvent {
  final String paymentId;

  const ConfirmPayment({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}

class CancelPayment extends PaymentEvent {}

class RetryPayment extends PaymentEvent {}

class UpdateShoppingCart extends PaymentEvent {
  final List<CartItem> newShoppingCart;

  const UpdateShoppingCart({required this.newShoppingCart});

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
