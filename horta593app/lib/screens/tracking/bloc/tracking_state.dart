part of 'tracking_bloc.dart';

@immutable
abstract class TrackingState extends Equatable {}

class TrackingInitialState extends TrackingState {
  @override
  List<Object?> get props => [];
}
