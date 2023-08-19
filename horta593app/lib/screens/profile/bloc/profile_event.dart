part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileRequestEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class OrdersRequestEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
