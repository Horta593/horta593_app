part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object> get props => [];
}

//Categories
class CategoryLoadedState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategorySuccessState extends CategoriesState {
  final List<Category> categories;
  const CategorySuccessState(this.categories);
  @override
  List<Object> get props => [categories];
}

class CategoriesProductsSuccessState extends CategoriesState {
  final List<Category> categories;
  final Map<String, List<Product>> productsCategories;
  const CategoriesProductsSuccessState(
      this.categories, this.productsCategories);
  @override
  List<Object> get props => [categories];
}

class CategoryErrorState extends CategoriesState {
  final Exception exception;

  const CategoryErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
