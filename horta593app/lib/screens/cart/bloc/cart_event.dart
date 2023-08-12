part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends CartEvent {
  final CartItem item;

  const AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemEvent extends CartEvent {
  final CartItem item;

  const RemoveItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class ChangeQuantityEvent extends CartEvent {
  final CartItem item;
  final int newQuantity;

  const ChangeQuantityEvent(this.item, this.newQuantity);

  @override
  List<Object> get props => [item, newQuantity];
}

class CartEmptyEvent extends CartEvent {
  const CartEmptyEvent();

  @override
  List<Object> get props => [];
}
