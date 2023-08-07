// ignore_for_file: empty_constructor_bodies

import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:horta593app/exceptions/user_exceptions.dart';

class User {
  final int id;
  String email;
  String firstName;
  String lastName;
  String adress;
  String accessToken;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.adress,
    required this.accessToken,
  }) {
    if (isValidToken()) {
      getNewToken();
    } else {
      throw InvalidUserException();
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final user = User(
      id: json['userId'],
      email: json['userEmail'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      adress: json['userAddress'],
      accessToken: json['access'],
    );
    if (user.isValidToken()) {
      return user;
    } else {
      throw InvalidUserException();
    }
  }

  String fullName() {
    return firstName + ' ' + lastName;
  }

  bool isValidToken() {
    final jwtData = JwtDecoder.decode(accessToken);
    return jwtData['exp'] < DateTime.now().millisecondsSinceEpoch;
  }

  void getNewToken() async {
    final jwtData = JwtDecoder.decode(accessToken);
    await Future.delayed(
      Duration(
        milliseconds:
            jwtData['exp'] * 1000 - DateTime.now().millisecondsSinceEpoch,
      ),
    );
    getNewToken();
  }

  String toJson() {
    return jsonEncode(
      {
        'userId': id,
        'userEmail': email,
        'userFirstName': firstName,
        'userLastName': lastName,
        "access": accessToken,
      },
    );
  }
}
