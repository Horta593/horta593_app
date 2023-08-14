part of 'google_map_bloc.dart';

abstract class GoogleMapState extends Equatable {
  const GoogleMapState();

  @override
  List<Object> get props => [];
}

class GoogleMapInitial extends GoogleMapState {}

class GoogleMapChange extends GoogleMapState {}
