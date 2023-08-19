import 'package:horta593app/services/helper_service.dart';
import 'package:horta593app/services/profile_service.dart';
import 'package:horta593app/services/secure_storage_service.dart';

import '../constants/api_constanst.dart';
import '../exceptions/form_exceptions.dart';
import '../exceptions/secure_storage_exceptions.dart';
import '../model/cart_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product_order_model.dart';
import '../model/user_model.dart';

class PaymentService {
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

  static Future<String> generateOrder(List<CartItem> shoppingcart) async {
    User user_response = await ProfileService.getProfileInfo();

    String url = "${API.BASE_URL}${API.ORDER_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;

    List<Map<String, dynamic>> product_orders = [];
    for (CartItem cartitem in shoppingcart) {
      ProductOrder prod_ord = ProductOrder(
          productId: cartitem.product.id,
          special_note: "",
          quantity: cartitem.quantity,
          discount: 0);
      product_orders.add(prod_ord.toJson());
    }
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'userId': user_response.id,
          'orderDetails': product_orders,
          'special_note': ''
        }),
        headers: HelperService.buildHeaders(accessToken: token));
    switch (response.statusCode) {
      case 201:
        final result = jsonDecode(response.body);
        final String id = result['id'];
        return id;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<String> getOrderbyUser(String userID) async {
    String url = "${API.BASE_URL}${API.ORDERUSER_ENDPOINT}";
    url = url.replaceFirst('{id}', userID);
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final Map<String, dynamic> idOrder = result.last;
        return idOrder['id'];
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<Map<String, dynamic>> getAllOrdersbyUser(String userID) async {
    String url = "${API.BASE_URL}${API.ORDERUSER_ENDPOINT}";
    url = url.replaceFirst('{id}', userID);
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final Map<String, dynamic> ordersUser = result;
        return ordersUser;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<String> confirmPayment(
      String idorder, String name, String nationalID) async {
    String url = "${API.BASE_URL}${API.PAYMENT_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'orderId': idorder,
          'firstName': name.split(" ")[0],
          'lastName': name.split(" ")[1],
          'nationalId': nationalID
        }),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 201:
        final result = jsonDecode(response.body);
        final String id = result['id'];
        return id;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<String> uploadPayment(String idorderD) async {
    // User user_response = await ProfileService.getProfileInfo();

    String url = "${API.BASE_URL}${API.PAYMENT_ENDPOINT}";
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({}),
        headers: HelperService.buildHeaders(accessToken: token));

    switch (response.statusCode) {
      case 201:
        final result = jsonDecode(response.body);
        final String id = result['id'];
        return id;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<String> getOrderStatus(String orderid) async {
    // User user_response = await ProfileService.getProfileInfo();

    String url = "${API.BASE_URL}${API.ORDER_STATUS_ENDPOINT}";
    url = url.replaceFirst('{orderId}', orderid);
    User user = await loadUser();
    String token = user.accessToken;

    final response = await http.get(Uri.parse(url),
        headers: HelperService.buildHeaders(accessToken: token));
    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final String status = result['status'];
        return status;
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
