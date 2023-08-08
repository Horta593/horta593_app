part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {}

class PlaceOrderEvent extends OrderEvent {
  final Cart cart;

  PlaceOrderEvent(this.cart);
  @override
  List<Object?> get props => [cart];
}

class RemoveOrderEvent extends OrderEvent {
  final Cart cart;

  RemoveOrderEvent(this.cart);
  @override
  List<Object?> get props => [cart];
}


// class GetCart extends OrderEvent {}