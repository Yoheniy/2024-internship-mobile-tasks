class Urls {
  static const String CACHED_PRODUCTS = 'CACHED_PRODUCTS';
  static const String apiKey = '';
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/av1pi/';
  static const String allProductUrl = '$baseUrl/products';
  static const Map<String, String> jsonHeader = {'Content-Type': 'application/json'};
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static String getSingleProdcut(String id) => '$allProductUrl/$id';

}

