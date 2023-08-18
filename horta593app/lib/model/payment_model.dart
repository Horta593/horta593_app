import 'package:equatable/equatable.dart';
import 'package:horta593app/model/product_order_model.dart';

// ignore: must_be_immutable
class PaymentModel extends Equatable {
  String id;
  String orderId;
  String transferImage;
  String firstName;
  String lastName;
  String nationalId;
  DateTime paymentDate;
  DateTime createdAt;
  DateTime updatedAt;
  ProductOrder order;

  PaymentModel(
      {required this.id,
      required this.orderId,
      required this.transferImage,
      required this.firstName,
      required this.lastName,
      required this.nationalId,
      required this.paymentDate,
      required this.createdAt,
      required this.updatedAt,
      required this.order});

  @override
  List<Object?> get props => [
        id,
        orderId,
        transferImage,
        firstName,
        lastName,
        nationalId,
        paymentDate,
        createdAt,
        updatedAt,
        order
      ];

  //crear objeto a partir de un Json
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    PaymentModel payment = PaymentModel(
        id: json['id'],
        orderId: json['orderId'],
        transferImage: json['transferImage'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        nationalId: json['nationalId'],
        paymentDate: json['paymentDate'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        order: json['order']);
    return payment;
  }
}
