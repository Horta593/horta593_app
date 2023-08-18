import 'dart:convert';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductOrder extends Equatable {
  String productId;
  // ignore: non_constant_identifier_names
  String special_note;
  int quantity;
  int discount;

  ProductOrder({
    required this.productId,
    // ignore: non_constant_identifier_names
    required this.special_note,
    required this.quantity,
    required this.discount,
  });

  @override
  List<Object?> get props => [productId, special_note, quantity, discount];

  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    ProductOrder order = ProductOrder(
      productId: json['productId'],
      special_note: json['special_note'],
      quantity: json['quantity'],
      discount: json['discount'],
    );
    return order;
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'special_note': special_note,
      'quantity': quantity,
      'discount': discount,
    };
  }
}
