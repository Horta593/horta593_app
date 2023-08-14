import 'dart:convert';

import '../constants/api_constanst.dart';
import '../exceptions/form_exceptions.dart';
import '../exceptions/secure_storage_exceptions.dart';
import '../model/user_model.dart';
import 'helper_service.dart';
import 'secure_storage_service.dart';
import 'package:http/http.dart' as http;

class ProfileService {
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

  static Future<User> getProfileInfo() async {
    String url = "${API.BASE_URL}${API.ME_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        json['accessToken'] = token;
        final user = User.fromJsonInfo(json);

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
