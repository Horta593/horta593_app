part of 'cart_bloc.dart';

abstract class CartState {
  final List<CartItem> items;

  CartState({this.items = const []});
}

class CartEmpty extends CartState {
  CartEmpty() : super(items: []);
}

class CartLoaded extends CartState {
  final List<CartItem> newItems;
  CartLoaded(this.newItems) : super(items: newItems);
}

class CartItemRemoved extends CartState {
  final List<CartItem> updatedItems;

  CartItemRemoved(List<CartItem> items, this.updatedItems)
      : super(items: updatedItems);
}

class AddQuantityProduct extends CartState {
  final List<CartItem> newItems;
  AddQuantityProduct(this.newItems) : super(items: newItems);
}
