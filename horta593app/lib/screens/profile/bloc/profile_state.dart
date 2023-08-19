part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

// ignore: must_be_immutable
class ProfileSuccessfullState extends ProfileState {
  User user;
  ProfileSuccessfullState(this.user);
  @override
  List<Object> get props => [user];
}

// ignore: must_be_immutable
class OrdersUserSuccessfullState extends ProfileState {
  Map<String, dynamic> userOrders;
  OrdersUserSuccessfullState(this.userOrders);
  @override
  List<Object> get props => [userOrders];
}

class ProfileErrorState extends ProfileState {
  final Exception exception;

  const ProfileErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
