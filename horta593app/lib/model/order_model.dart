import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:horta593app/model/cart_item_model.dart';

// ignore: must_be_immutable
class Order extends Equatable {
  String id;
  String userId;
  String createdAt;
  String updatedAt;
  String status;
  String specialNote;
  String shipmentType;
  String amount;
  List<CartItem> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.specialNote,
    required this.shipmentType,
    required this.amount,
    required this.orderDetails,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        createdAt,
        updatedAt,
        status,
        specialNote,
        shipmentType,
        amount,
        orderDetails
      ];

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['userId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        status: json['status'],
        specialNote: json['special_note'],
        shipmentType: json['shipmentType'],
        amount: json['amount'],
        orderDetails: json['orderDetails']);
  }
}
