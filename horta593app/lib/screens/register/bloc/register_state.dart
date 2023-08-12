part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterFormSuccessState extends RegisterState {
  final User user;

  const RegisterFormSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterSuccessState extends RegisterState {
  final User user;

  const RegisterSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterErrorState extends RegisterState {
  final Exception exception;

  const RegisterErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
