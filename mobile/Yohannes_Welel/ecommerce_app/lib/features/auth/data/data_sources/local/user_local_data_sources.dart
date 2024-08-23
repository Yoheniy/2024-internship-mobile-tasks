import 'dart:convert'; // Import the dart:convert package
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exception.dart';
import '../../models/user/user_model.dart';


abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();
  Future<void> cacheUser(UserModel userToCache);
  Future<void> cacheAccessToken(String accessToken);
  Future<String?> getAccessToken();
  Future<void> clearCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  static const cachedUserKey = 'CACHED_USER';
  static const accessTokenKey = 'ACCESS_TOKEN';

  @override
  Future<void> cacheAccessToken(String accessToken) async {
    await sharedPreferences.setString(accessTokenKey, accessToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(accessTokenKey);
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedUserKey);
    await sharedPreferences.remove(accessTokenKey);
  }

  @override
  Future<void> cacheUser(UserModel userToCache) async {
    final jsonString =
        json.encode(userToCache.toJson()); // Convert UserModel to JSON string
    await sharedPreferences.setString(cachedUserKey, jsonString);
  }

  @override
  Future<UserModel> getCachedUser() async {
    final jsonString = sharedPreferences.getString(cachedUserKey);

    if (jsonString != null) {
      return UserModel.fromJson(
          json.decode(jsonString)); // Decode JSON string to UserModel
    } else {
      throw CacheException();
    }
  }
}

