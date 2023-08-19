class API {
  static const String BASE_URL = "http://44.212.161.237:3000";

  //Authentication
  //[POST]
  static const String LOGIN_ENDPOINT = '/auth/signin';
  //[POST]
  static const String SIGNUP_ENDPOINT = '/auth/signup';

  //Products
  // [GET]
  static const String PRODUCT_ENDPOINT = '/product';

  //Categories
  //[GET]
  static const String CATEGORIES_ENDPOINT = '/category';
  //[GET]
  static const String PRODUCT_BY_CATEGORY_ENDPOINT = "/category/{id}/products";

  //User
  //[GET]
  static const String ME_ENDPOINT = '/user/me';

  //[GET]
  static const String MELOCATION_ENDPOINT = '/user/me/location';

  //[PATCH]
  static const String CHANGELOCATION_ENDPOINT = '/user/{id}/address';

  //Order
  //[POST]
  static const String ORDER_ENDPOINT = '/order';

  //[GET]
  static const String ORDERUSER_ENDPOINT = '/order/{id}/orders/all';

  //[POST]
  static const String PAYMENT_ENDPOINT = '/payment';

  //[GET]
  static const String ORDER_STATUS_ENDPOINT = '/order/{orderId}/status';
}
