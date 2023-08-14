import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../exceptions/form_exceptions.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import '../../../services/category_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoryLoadedState()) {
    on<CategoryRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadedState());
        try {
          final categories = await CategoryService.getCategories();
          emit(CategorySuccessState(categories));
          Map<String, List<Product>> productsCategory = {};

          for (var category in categories) {
            List<Product> products =
                await CategoryService.getProductbyCategory(category.id);
            productsCategory[category.id] = products;
          }
          emit(CategoriesProductsSuccessState(categories, productsCategory));
        } on FormGeneralException catch (e) {
          emit(CategoryErrorState(e));
        } on FormFieldsException catch (e) {
          emit(CategoryErrorState(e));
        } catch (e) {
          emit(CategoryErrorState(
            FormGeneralException(message: 'Something error.'),
          ));
        }
      },
    );
  }
}
