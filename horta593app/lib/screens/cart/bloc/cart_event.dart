part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;
  const AddProduct(this.product);
}

class RemoveProduct extends CartEvent {
  final Product product;
  const RemoveProduct(this.product);
}
