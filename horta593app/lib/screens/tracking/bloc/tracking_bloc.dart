import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:horta593app/services/payment_service.dart';

import '../../../exceptions/form_exceptions.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitialState()) {
    on<TrackingInitialEvent>((event, emit) async {
      emit(TrackingInitialState());
      try {
        final idPayment = await PaymentService.confirmPayment(
            event.orderID, event.name, event.nationalID);
        print("TrackingSuccessPayment");
        emit(TrackingSuccessPayment());
      } on FormGeneralException catch (e) {
        emit(TrackingErrorlState(e));
      } on FormFieldsException catch (e) {
        emit(TrackingErrorlState(e));
      } catch (e) {
        emit(TrackingErrorlState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    });

    on<TrackingPaymentlEvent>((event, emit) async {
      print("TrackingPaymentlEvent!!!!");
      print(state);
      if (state is TrackingSuccessPayment) {
        // Aquí es donde debes hacer lo que quieras cuando el estado es TrackingSuccessPayment
        // Por ejemplo, puedes emitir otro estado o hacer alguna lógica de negocio.
        // Por ahora, simplemente estoy emitiendo el mismo estado TrackingSuccessPayment de nuevo.
        emit(TrackingSuccessPayment());
      }
    });
  }
}
