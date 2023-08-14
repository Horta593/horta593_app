part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterValidationEvent extends RegisterEvent {
  final User user;

  const RegisterValidationEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class RegisterRequestEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const RegisterRequestEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}
