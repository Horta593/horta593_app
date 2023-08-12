import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/user_model.dart';
import 'package:horta593app/services/auth_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterValidationEvent>(((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      User userE =
          User(email: "", firstName: "", lastName: "", accessToken: "");
      emit(RegisterFormSuccessState(user: userE));
    }));
    on<RegisteredEvent>(
      (event, emit) {
        if (state is RegisterFormSuccessState) {
          final state = this.state as RegisterSuccessState;
          emit(RegisterFormSuccessState(user: event.user));
        }
      },
    );
  }
}
