part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CategoryRequestEvent extends CategoriesEvent {
  @override
  List<Object> get props => [];
}
