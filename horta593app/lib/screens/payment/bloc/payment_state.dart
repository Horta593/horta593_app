part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {
  final Pay newPay;

  const PaymentLoadingState({required this.newPay});

  @override
  List<Object?> get props => [newPay];
}

class PaymentReadyState extends PaymentState {
  final Pay newPay;

  const PaymentReadyState({required this.newPay});

  @override
  List<Object?> get props => [newPay];
}
