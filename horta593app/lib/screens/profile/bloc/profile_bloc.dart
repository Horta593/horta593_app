import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/services/profile_service.dart';

import '../../../exceptions/form_exceptions.dart';
import '../../../model/user_model.dart';
import '../../../services/payment_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileRequestEvent>((event, emit) async {
      emit(ProfileInitialState());

      try {
        final user = await ProfileService.getProfileInfo();
        emit(ProfileSuccessfullState(user));
      } on FormGeneralException catch (e) {
        emit(ProfileErrorState(e));
      } on FormFieldsException catch (e) {
        emit(ProfileErrorState(e));
      } catch (e) {
        emit(ProfileErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    });

    on<OrdersRequestEvent>(((event, emit) async {
      try {
        String userId = await ProfileService.getIDUser();
        final Map<String, dynamic> order =
            await PaymentService.getAllOrdersbyUser(userId);

        emit(OrdersUserSuccessfullState(order));
      } on FormGeneralException catch (e) {
        emit(ProfileErrorState(e));
      } on FormFieldsException catch (e) {
        emit(ProfileErrorState(e));
      } catch (e) {
        emit(ProfileErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    }));
  }
}
