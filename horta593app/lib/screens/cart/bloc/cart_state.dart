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

//just in case!

class CartItemRemovedState extends CartState {
  final List<CartItem> updatedItems;

  const CartItemRemovedState(List<CartItem> items, this.updatedItems)
      : super(shoppingCart: updatedItems);

  @override
  List<Object> get props => [updatedItems];
}

class AddQuantityProductState extends CartState {
  final List<CartItem> newItems;
  const AddQuantityProductState(this.newItems) : super(shoppingCart: newItems);

  @override
  List<Object> get props => [newItems];
}
