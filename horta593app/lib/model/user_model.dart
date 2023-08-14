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
  String? latitude;
  String? longitud;
  String? address;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.accessToken,
    this.latitude,
    this.longitud,
    this.address,
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

  factory User.fromJsonInfo(Map<String, dynamic> json) {
    final user = User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: "",
        accessToken: json['accessToken'],
        latitude: json['latitude'],
        longitud: json['longitud'],
        address: json['address']);
    if (user.isValidToken()) {
      return user;
    } else {
      throw InvalidUserException();
    }
  }

  String fullName() {
    return firstName.toUpperCase() + ' ' + lastName.toUpperCase();
  }

  List<String> getLocation() {
    if (latitude != null && longitud != null) return [latitude!, longitud!];
    return [];
  }

  String getAddress() {
    if (address != null) return address!;
    return '';
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
