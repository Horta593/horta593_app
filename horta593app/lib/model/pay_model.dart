import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';

// ignore: must_be_immutable
class Pay extends Equatable {
  String name;
  String personalId;
  String email;
  List<CartItem> shoppingCart;

  Pay(
      {required this.name,
      required this.personalId,
      required this.email,
      // ignore: empty_constructor_bodies
      required this.shoppingCart}) {}

  @override
  List<Object?> get props => [name, personalId, email];
}
