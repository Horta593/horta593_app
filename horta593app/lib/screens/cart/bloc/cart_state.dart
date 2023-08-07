part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<Product> products;
  const CartState({this.products = const []});

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartEmpty extends CartState {
  CartEmpty() : super(products: []);
}

class CartLoaded extends CartState {
  final List<Product> newProducts;
  const CartLoaded(this.newProducts) : super(products: newProducts);
}
