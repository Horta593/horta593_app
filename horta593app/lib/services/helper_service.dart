class HelperService {
  static const String host = "127.0.0.1";
  static const int port = 3000;
  static const String scheme = "http";
  static const String apiPath = "/";

  static Uri buildUri(String path) {
    return Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: apiPath + path,
    );
  }

  static Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "*/*",
      "Content-Type": "application/json"
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
