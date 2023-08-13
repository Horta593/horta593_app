import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:horta593app/exceptions/form_exceptions.dart';
import 'package:horta593app/exceptions/secure_storage_exceptions.dart';
import 'package:horta593app/model/user_model.dart';
import 'package:horta593app/services/secure_storage_service.dart';
import 'package:horta593app/services/helper_service.dart';

import '../constants/api_constanst.dart';

class AuthService {
  static const String loginPath = 'token/';
  static const String registerPath = 'users/';
  static const String refreshPath = 'token/refresh/';
  static const String verifyPath = 'token/verify/';

  static Future<User> loadUser() async {
    final json = await SecureStorageService.storage.read(
      key: SecureStorageService.userKey,
    );
    if (json != null) {
      return User.fromJson(jsonDecode(json));
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  static void saveUser(User user) async {
    await SecureStorageService.storage.write(
      key: SecureStorageService.userKey,
      value: user.toJson(),
    );
  }

  static Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    String url = "${API.BASE_URL}${API.SIGNUP_ENDPOINT}";
    final response = await http.post(
      Uri.parse(url),
      headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'role': ''
        },
      ),
    );

    switch (response.statusCode) {
      case 201:
        final json = jsonDecode(response.body);
        json['userFirstName'] = firstName;
        json['userLastName'] = lastName;
        json['password'] = password;
        json['userEmail'] = email;

        final user = User.fromJson(json);
        saveUser(user);

        return user;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<void> logout() async {
    await SecureStorageService.storage.delete(
      key: SecureStorageService.userKey,
    );
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    String url = "${API.BASE_URL}${API.LOGIN_ENDPOINT}";
    final response = await http.post(
      Uri.parse(url),
      headers: HelperService.buildHeaders(),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        json['userFirstName'] = '';
        json['userLastName'] = '';
        json['password'] = '';
        json['userEmail'] = email;

        final user = User.fromJson(json);

        saveUser(user);

        return user;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }
}
