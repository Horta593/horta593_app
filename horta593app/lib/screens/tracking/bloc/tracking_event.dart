part of 'tracking_bloc.dart';

@immutable
class TrackingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class TrackingInitialEvent extends TrackingEvent {
  String orderID;
  String name;
  String nationalID;

  TrackingInitialEvent(this.orderID, this.name, this.nationalID);
  @override
  List<Object?> get props => [orderID, name, nationalID];
}

class TrackingPaymentlEvent extends TrackingEvent {}

class RequestOrderStatusEvent extends TrackingEvent {}
