import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitialState()) {
    on<TrackingInitialEvent>((event, emit) async {
      // payment:confirmacion de pago
      // llamar funcion de request /payment : idPayment receive
      // payment-upload  form data, como enviar formdata como un body del enpoint, genera el id del payment
      //
      // TODO: implement event handler
    });
  }
}
