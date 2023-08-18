import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/screens/payment/bloc/payment_event.dart';
import 'package:horta593app/services/payment_service.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitialState()) {
    on<InitializePaymentEvent>((event, emit) async {
      final id_ = await PaymentService.generateOrder(event.shoppingCart);
      emit(PaymentReadyState(
          idOrder: id_, subtotal: event.subTotal, total: event.total));
      print("PaymentReadyState");
      // emit(PaymentLoadingState(newPay: event.pay));
      // emit(PaymentReadyState(newPay: event.pay));
    });
  }
}
