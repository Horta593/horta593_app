part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  // const PaymentEvent();
  @override
  List<Object> get props => [];
}

class UpdatePayment extends PaymentEvent {
  final Pay updatedPay;

  UpdatePayment({required this.updatedPay});

  @override
  List<Object> get props => [updatedPay];
}

class MakePayment extends PaymentEvent {
  final Pay pay;
  MakePayment({required this.pay});
}
