class Urls {
  static const String baseUrl ='https://g5-flutter-learning-path-be.onrender.com/api/v2/products';
  static String getProductId(String id) => '$baseUrl/$id';
  static String deleteProductId(String id) => '$baseUrl/$id';
  static const String getProducts = '$baseUrl';
  static const String addProduct = '$baseUrl';
  static String updateProductId(String id) => '$baseUrl/$id';
  static const String baseUrlAuth='https://g5-flutter-learning-path-be.onrender.com/api/v2';
  static const String baseUrlsignup='https://g5-flutter-learning-path-be.onrender.com/api/v2/auth/register';
  static const String baseUrlsignin='https://g5-flutter-learning-path-be.onrender.com/api/v2/auth/login';
  static const String baseUrlsme='https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me';

}
