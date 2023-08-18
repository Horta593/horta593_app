import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import '../constants/api_constanst.dart';
import '../exceptions/form_exceptions.dart';
import '../exceptions/secure_storage_exceptions.dart';
import '../model/location_model.dart';
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

  static Future<LocationUser> getMeLocation() async {
    String url = "${API.BASE_URL}${API.MELOCATION_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;

    print(url);

    final response = await http.get(
      Uri.parse(url),
      headers: HelperService.buildHeaders(accessToken: token),
    );
    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        final locationuser = LocationUser.fromJson(json);
        print(locationuser.latitude);
        print(locationuser.longitude);
        print(locationuser.address);
        return locationuser;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<LocationUser> changeLocation(
      Position position, String addrr) async {
    User user_response = await getProfileInfo();

    String url = "${API.BASE_URL}${API.CHANGELOCATION_ENDPOINT}";
    print("ID");
    print(user_response.id);
    url = url.replaceFirst('{id}', user_response.id);
    User user = await loadUser();
    String token = user.accessToken;
    final response = await http.patch(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token),
        body: jsonEncode({
          "address": addrr,
          "latitude": position.latitude,
          "longitude": position.longitude
        }));

    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        final locationuser = LocationUser.fromJson(json['user']);

        print(locationuser);
        return locationuser;
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
