import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddItemEvent>((event, emit) {
      List<CartItem> newList = [...state.shoppingCart, event.item];
      emit(CartLoaded(newList));
    });

    on<RemoveItemEvent>((event, emit) {
      List<CartItem> updateProductos = state.shoppingCart
          .where((element) =>
              element.product.idProduct != event.item.product.idProduct)
          .toList();
      emit(CartLoaded(updateProductos));
    });
  }
}
