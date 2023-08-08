import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'product_model.dart';
import 'item_model.dart';

class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({required this.items});

  void addItem(Product product, int quantity) {
    for (var item in items) {
      if (item.product.idProduct == product.idProduct) {
        int total = item.quantity;
        total += quantity;
        return;
      }
    }
    items.add(CartItem(product: product, quantity: quantity));
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  @override
  List<Object?> get props => [items];
}

// class Cart extends Equatable {
//   final List<CartItem> items = [];

//   void addItem(Product product, int quantity) {
//     for (var item in items) {
//       if (item.product.idProduct == product.idProduct) {
//         item.quantity += quantity;
//         return;
//       }
//     }
//     items.add(CartItem(product: product, quantity: quantity));
//   }

//   void removeItem(Product product) {
//     items.removeWhere((item) => item.product.idProduct == product.idProduct);
//   }

//   double getTotalPrice() {
//     double total = 0;
//     for (var item in items) {
//       total += item.product.price * item.quantity;
//     }
//     return total;
//   }

// double get total {
  //   return items.fold(
  //       0, (total, item) => total + item.product.price * item.quantity);
  // }

//   @override
//   List<Object?> get props => [items];
// }


// class Cart {
//   late final int? id;
//   final String? productId;
//   final String? productName;
//   final int? initialPrice;
//   final int? productPrice;
//   final ValueNotifier<int>? quantity;
//   final String? unitTag;
//   final String? image;
// }
