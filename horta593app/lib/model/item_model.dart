import 'product_model.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product, quantity];
}
