import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:horta593app/services/payment_service.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitialState()) {
    on<TrackingInitialEvent>((event, emit) async {
      // payment:confirmacion de pago
      // llamar funcion de request /payment : idPayment receive
      final idPayment = await PaymentService.confirmPayment(
          event.orderID, event.name, event.nationalID);
      // payment-upload  form data, como enviar formdata como un body del enpoint, genera el id del payment

      //
      // TODO: implement event handler
    });
  }
}
