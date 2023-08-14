import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/product_model.dart';
import 'package:horta593app/services/product_service.dart';

import '../../../exceptions/form_exceptions.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadedState()) {
    on<ProductRequestEvent>((event, emit) async {
      emit(ProductLoadedState());
      try {
        final productsMenu = await ProductService.getProducts();

        emit(ProductSuccessState(productsMenu));
      } on FormGeneralException catch (e) {
        emit(ProductErrorState(e));
      } on FormFieldsException catch (e) {
        emit(ProductErrorState(e));
      } catch (e) {
        emit(ProductErrorState(
          FormGeneralException(message: 'Something error.'),
        ));
      }
    });
  }
}
