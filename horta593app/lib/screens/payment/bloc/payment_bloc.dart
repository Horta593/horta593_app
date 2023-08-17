import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/pay_model.dart';
import 'package:horta593app/screens/payment/bloc/payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitialState()) {
    on<InitializePaymentEvent>((event, emit) {
      emit(PaymentLoadingState(newPay: event.pay));
      emit(PaymentReadyState(newPay: event.pay));
    });
  }
}
