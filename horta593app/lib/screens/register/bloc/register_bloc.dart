import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/user_model.dart';
import 'package:horta593app/services/auth_service.dart';

import '../../../exceptions/form_exceptions.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterFormState()) {
    on<RegisterRequestEvent>(((event, emit) async {
      emit(RegisterLoadingState());
      try {
        final user = await AuthService.register(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        );
        print("await user");
        print(await user);
        emit(RegisterSuccessState(user));
      } on FormGeneralException catch (e) {
        emit(RegisterErrorState(e));
      } on FormFieldsException catch (e) {
        emit(RegisterErrorState(e));
      } catch (e) {
        emit(RegisterErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    }));
  }
}
