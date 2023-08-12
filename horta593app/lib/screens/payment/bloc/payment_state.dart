part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentReady extends PaymentState {
  final Pay newPay;

  const PaymentReady({required this.newPay});

  @override
  List<Object> get props => [newPay];
}
