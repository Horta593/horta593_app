import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/pay_model.dart';
import 'package:horta593app/model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const ProductLoaded(products: <Product>[]));
    });
  }
}
