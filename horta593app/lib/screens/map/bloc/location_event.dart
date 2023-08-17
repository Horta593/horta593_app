part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object?> get props => [];
}

class LocationRequestEvent extends LocationEvent {
  const LocationRequestEvent();
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class UpdatedLocationUserEvent extends LocationEvent {
  Position newposicion;
  String addr;
  UpdatedLocationUserEvent(this.newposicion, this.addr);
  @override
  List<Object?> get props => [newposicion, addr];
}
