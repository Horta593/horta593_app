part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<CartItem> shoppingCart;

  const CartState({this.shoppingCart = const []});

  @override
  List<Object> get props => [];
}

class CartEmptyState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final List<CartItem> shoppingCart;
  const CartLoadedState(this.shoppingCart);
  @override
  List<Object> get props => [shoppingCart];
}
