part of 'tracking_bloc.dart';

@immutable
abstract class TrackingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackingInitialState extends TrackingState {
  @override
  List<Object?> get props => [];
}

class TrackingSuccessPaymentID extends TrackingState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class TrackingSuccessPayment extends TrackingState {
  final String idOrder;

  TrackingSuccessPayment({required this.idOrder});

  @override
  List<Object> get props => [idOrder];
}

class TrackingOrderSuccessPayment extends TrackingState {
  @override
  List<Object> get props => [];
}

class OrderSentState extends TrackingState {
  @override
  List<Object> get props => [];
}

class OrderProcessState extends TrackingState {
  @override
  List<Object> get props => [];
}

class OrderReadyState extends TrackingState {
  @override
  List<Object> get props => [];
}

class TrackingTryPayment extends TrackingState {
  @override
  List<Object> get props => [];
}

class TrackingErrorlState extends TrackingState {
  final Exception exception;

  TrackingErrorlState(this.exception);

  @override
  List<Object> get props => [exception];
}

class OrderCompletedState extends TrackingState {
  @override
  List<Object> get props => [];
}
