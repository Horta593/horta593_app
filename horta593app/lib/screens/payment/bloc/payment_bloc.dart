import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/pay_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<UpdatePayment>((event, emit) {
      Pay newpayment = event.updatedPay;
      emit(UpdatePayment(updatedPay: newpayment) as PaymentState);
    });
  }
}
