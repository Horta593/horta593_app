part of 'cart_bloc.dart';

abstract class CartEvent {}


class AddItem extends CartEvent {

  final CartItem item;
  AddItem(this.item);
}

class RemoveProduct extends CartEvent {
  final Product item;
  RemoveProduct(this.item);
}

class UpdateQuantity extends CartEvent {
  final CartItem item;
  final int newQuantity;

  UpdateQuantity(this.item, this.newQuantity);
}
