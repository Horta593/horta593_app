part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginFormState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User user;

  const LoginSuccessState(this.user);
}

class LoginErrorState extends LoginState {
  final Exception exception;

  const LoginErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
