part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadedState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductSuccessState extends ProductState {
  final List<Product> products;
  const ProductSuccessState(this.products);
  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {
  final Exception exception;

  const ProductErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}

class CategoryLoadedState extends ProductState {
  @override
  List<Object> get props => [];
}

class CategorySuccessState extends ProductState {
  final List<Category> categories;
  const CategorySuccessState(this.categories);
  @override
  List<Object> get props => [categories];
}
