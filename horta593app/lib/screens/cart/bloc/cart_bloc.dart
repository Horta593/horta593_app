import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmptyState()) {
    on<LoadItemCounter>((event, emit) {
      emit(CartEmptyState());
    });

    on<AddItemEvent>((event, emit) {
      if (state is CartEmptyState) {
        emit(CartLoadedState([event.currentItem]));
      } else if (state is CartLoadedState) {
        bool itemExists = state.shoppingCart.any(
            (element) => element.product.id == event.currentItem.product.id);

        if (!itemExists) {
          emit(CartLoadedState(
              List.from((state as CartLoadedState).shoppingCart)
                ..add(event.currentItem)));
        } else {
          CartItem itm = state.shoppingCart
              .where((element) =>
                  element.product.id == event.currentItem.product.id)
              .first;

          int newQty = event.currentItem.quantity + itm.quantity;

          CartItem newItem = CartItem(product: itm.product, quantity: newQty);

          state.shoppingCart.add(newItem);

          emit(CartLoadedState(
              List.from((state as CartLoadedState).shoppingCart)..remove(itm)));
        }
      }
    });

    on<RemoveItemEvent>((event, emit) {
      if (state is CartLoadedState) {
        emit(CartLoadedState(List.from((state as CartLoadedState).shoppingCart)
          ..remove(event.item)));
      }
    });

    //just in. case;
    // on<ChangeQuantityEvent>((event, emit) {});
  }
}
