import 'dart:convert';
import 'package:http/http.dart' as http;


import '../../../../../core/error/exception.dart';
import '../../models/user/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String accessToken);
  Future<String> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  static const String authBaseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/auth';
  static const String userBaseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/users';

  @override
  Future<UserModel> getUser(String accessToken) async {
    final response = await client.get(
      Uri.parse('$userBaseUrl/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(); // Handle error
    }
  }

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$authBaseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body)['data']['access_token'];
    } else {
      throw ServerException(); 
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('$authBaseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print(response.body);
    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException(); 
    }
  }
}


