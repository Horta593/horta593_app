import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:horta593app/model/product_order_model.dart';

// ignore: must_be_immutable
class PaymentModel extends Equatable {
  String orderId;
  String firstName;
  String lastName;
  String nationalId;

  PaymentModel({
    required this.orderId,
    required this.firstName,
    required this.lastName,
    required this.nationalId,
  });

  @override
  List<Object?> get props => [orderId, firstName, lastName, nationalId];

  //crear objeto a partir de un Json
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    PaymentModel payment = PaymentModel(
      orderId: json['orderId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nationalId: json['nationalId'],
    );
    return payment;
  }

  String toJson() {
    return jsonEncode(
      {
        'orderId': orderId,
        'firstName': firstName,
        'lastName': lastName,
        'nationalId': nationalId,
      },
    );
  }
}
