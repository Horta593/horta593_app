part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  final Cart cart;
  const OrderState({required this.cart});

  @override
  List<Object> get props => [];
}

class OrderEmpty extends OrderState {
  const OrderEmpty({required Cart cart}) : super(cart: cart);
}

class OrderExists extends OrderState {
  final Cart newCart;
  const OrderExists(this.newCart) : super(cart: newCart);
}
