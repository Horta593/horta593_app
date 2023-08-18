part of 'tracking_bloc.dart';

@immutable
class TrackingEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TrackingInitialEvent extends TrackingEvent {
  String orderID;
  TrackingInitialEvent(this.orderID);
  @override
  List<Object?> get props => [orderID];
}
