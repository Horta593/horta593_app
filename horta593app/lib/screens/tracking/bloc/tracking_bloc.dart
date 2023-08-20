import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:horta593app/services/payment_service.dart';
import 'package:horta593app/services/profile_service.dart';

import '../../../exceptions/form_exceptions.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  StreamSubscription? _pollingSubscription;

  TrackingBloc() : super(TrackingInitialState()) {
    _pollingSubscription = Stream.periodic(Duration(seconds: 10))
        .listen((_) => add(RequestOrderStatusEvent()));

    on<TrackingInitialEvent>((event, emit) async {
      emit(TrackingInitialState());
      try {
        emit(TrackingSuccessPayment(idOrder: event.orderID));
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

    on<RequestOrderStatusEvent>((event, emit) async {
      try {
        if (state is TrackingSuccessPayment ||
            state is OrderSentState ||
            state is OrderProcessState ||
            state is OrderReadyState) {
          final String idUser = await ProfileService.getIDUser();
          final String orderID = await PaymentService.getOrderbyUser(idUser);

          final String orderStatus =
              await PaymentService.getOrderStatus(orderID);

          switch (orderStatus) {
            case 'SENT':
              emit(OrderSentState());
              break;
            case 'IN_PROCESS':
              emit(OrderProcessState());
              break;
            case 'READY':
              emit(OrderReadyState());
              break;
            case 'COMPLETED':
              emit(OrderCompletedState());
              break;
            default:
              // manejar cualquier otro estado no esperado
              break;
          }
        }
      } catch (e) {
        print(e);
        emit(TrackingErrorlState(
          FormGeneralException(message: 'Error fetching order status.'),
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _pollingSubscription!
        .cancel(); // Asegúrate de cancelar la suscripción cuando el BLoC se cierre
    return super.close();
  }
}