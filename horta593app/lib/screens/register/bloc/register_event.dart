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

class RegisteredEvent extends RegisterEvent {
  final User user;

  const RegisteredEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
