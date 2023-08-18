import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class OrderDetails extends Equatable {
  String id;
  String orderId;
  String productId;
  String status;
  int quantity;
  String discount;
  String total;
  String specialNote;

  OrderDetails({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.status,
    required this.quantity,
    required this.discount,
    required this.total,
    required this.specialNote,
  });

  @override
  List<Object?> get props =>
      [id, orderId, productId, status, quantity, discount, total, specialNote];

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      orderId: json['orderId'],
      productId: json['productId'],
      status: json['status'],
      quantity: json['quantity'],
      discount: json['discount'],
      total: json['total'],
      specialNote: json['special_note'],
    );
  }
}
