import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmptyState()) {
    on<LoadItemCounter>((event, emit) {
      emit(CartEmptyState());
    });

    on<AddItemEvent>((event, emit) {
      if (state is CartEmptyState) {
        emit(CartLoadedState([event.item]));
      } else if (state is CartLoadedState) {
        emit(CartLoadedState(List.from((state as CartLoadedState).shoppingCart)
          ..add(event.item)));
      }
    });

    on<RemoveItemEvent>((event, emit) {
      if (state is CartLoadedState) {
        emit(CartLoadedState(List.from((state as CartLoadedState).shoppingCart)
          ..remove(event.item)));
      }
    });
  }
}
