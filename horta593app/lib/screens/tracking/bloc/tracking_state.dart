part of 'tracking_bloc.dart';

@immutable
abstract class TrackingState extends Equatable {}

class TrackingInitialState extends TrackingState {
  @override
  List<Object?> get props => [];
}

class TrackingSuccessPaymentID extends TrackingState {
  @override
  List<Object?> get props => [];
}

class TrackingSuccessPayment extends TrackingState {
  @override
  List<Object?> get props => [];
}

class TrackingErrorlState extends TrackingState {
  final Exception exception;

  TrackingErrorlState(this.exception);

  @override
  List<Object> get props => [exception];
}
