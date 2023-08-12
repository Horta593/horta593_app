part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<CartItem> shoppingCart;

  const CartState({this.shoppingCart = const []});

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {
  CartEmpty() : super(shoppingCart: []);
}

class CartLoaded extends CartState {
  final List<CartItem> newShoppingCart;
  const CartLoaded(this.newShoppingCart) : super(shoppingCart: newShoppingCart);
}
