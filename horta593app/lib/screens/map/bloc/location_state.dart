part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitialState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationEmptyState extends LocationState {}

// ignore: must_be_immutable
class LocationSuccesState extends LocationState {
  LocationUser position;
  LocationSuccesState(this.position);
  @override
  List<Object> get props => [position];
}

class LocationUpdatingState extends LocationState {}

class LocationUpdatedState extends LocationState {}

// ignore: must_be_immutable
class LocationUpdatedSuccesState extends LocationState {
  Position pos;
  LocationUpdatedSuccesState(this.pos);
  @override
  List<Object> get props => [pos];
}

class LocationErrorState extends LocationState {
  final Exception exception;

  const LocationErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
