import 'package:horta593app/model/product_model.dart';
import 'package:horta593app/services/helper_service.dart';
import 'package:horta593app/services/secure_storage_service.dart';

import '../constants/api_constanst.dart';
import '../exceptions/form_exceptions.dart';
import '../exceptions/secure_storage_exceptions.dart';
import '../model/category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user_model.dart';

class CategoryService {
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

  static Future<List<Category>> getCategories() async {
    String url = "${API.BASE_URL}${API.CATEGORIES_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;
    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));
    switch (response.statusCode) {
      case 200:
        final List result = jsonDecode(response.body);
        final List<Category> r =
            result.map((e) => Category.fromJson(e)).toList();
        return r;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<List<Product>> getProductbyCategory(String idCategory) async {
    String url = "${API.BASE_URL}${API.PRODUCT_BY_CATEGORY_ENDPOINT}";
    url = url.replaceFirst('{id}', idCategory);
    User user = await loadUser();
    String token = user.accessToken;
    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 200:
        final List result = jsonDecode(response.body);
        final List<Product> r = result.map((e) => Product.fromJson(e)).toList();
        return r;
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
