class API {
  static const String BASE_URL = "http://10.0.2.2:3001";

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
}
