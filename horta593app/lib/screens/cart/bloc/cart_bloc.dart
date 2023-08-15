import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';
import 'package:horta593app/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddItem>((event, emit) {
      // Check if the item already exists in the cart
      bool itemExists = state.items
          .any((element) => element.product.id == event.item.product.id);

      if (!itemExists) {
        List<CartItem> newList = [...state.items, event.item];
        emit(CartLoaded(newList));
      }
    });

    on<RemoveProduct>((event, emit) {
      List<CartItem> updateItems = state.items
          .where((element) => element.product.id != event.item.id)
          .toList();
      emit(CartItemRemoved(state.items, updateItems));
    });

    on<UpdateQuantity>((event, emit) {
      // Create a copy of the current list of items in the cart
      List<CartItem> updatedList = List.from(state.items);

      // Find the index of the item to be updated in the copied list
      int itemIndex = updatedList
          .indexWhere((item) => item.product.id == event.item.product.id);

      if (itemIndex != -1) {
        // Update the quantity of the item at the specified index
        updatedList[itemIndex] = event.item;
      } else {
        // If the item is not already in the list, add it
        updatedList.add(event.item);
      }

      emit(CartLoaded(updatedList)); // Emit the updated list
    });
  }
}
