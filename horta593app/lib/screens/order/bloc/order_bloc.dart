import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderEmpty(cart: Cart(items: []))) {
    on<PlaceOrderEvent>((event, emit) {
      Cart newCart = state.cart;
      emit(OrderExists(newCart));
    });
  }
}
