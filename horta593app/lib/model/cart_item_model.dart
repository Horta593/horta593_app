import 'package:equatable/equatable.dart';
import 'package:horta593app/model/product_model.dart';

class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
