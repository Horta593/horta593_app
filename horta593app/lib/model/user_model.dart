// ignore_for_file: empty_constructor_bodies

import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:horta593app/exceptions/user_exceptions.dart';

class User {
  String email;
  String firstName;
  String lastName;
  String password;
  String accessToken;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
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
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      email: json['userEmail'],
      password: json['password'],
      accessToken: json['accessToken'],
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
        'userEmail': email,
        'userFirstName': firstName,
        'userLastName': lastName,
        'password': password,
        "accessToken": accessToken,
      },
    );
  }
}
