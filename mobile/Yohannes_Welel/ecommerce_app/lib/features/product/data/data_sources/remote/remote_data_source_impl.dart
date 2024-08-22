import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failure.dart';
import '../../models/product_model.dart';
import '../local/user_local_data_sources.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource userLocalDataSource;

  RemoteDataSourceImpl(
      {required this.client, required this.userLocalDataSource});

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final accessToken = await userLocalDataSource.getAccessToken();
      if (accessToken == null) {
           throw CacheFailure('error cached occurred');
      }
      var request = http.MultipartRequest('POST', Uri.parse(Urls.addProduct));
      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();
      request.files.add(
        await http.MultipartFile.fromPath('image', product.imageUrl,
            contentType: MediaType('image', 'jpg')),
      );
      request.headers.addAll({'Authorization': 'Bearer $accessToken'});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        final jsonString = await response.stream.bytesToString();
        return ProductModel.fromJson(json.decode(jsonString)['data']);
      } else {
        throw ServerException();
      }
    } on Exception catch (e) {
      print('An error occurred: $e');
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteProduct(String id) async {
    try {
  final accessToken = await userLocalDataSource.getAccessToken();
  if (accessToken == null) {
      throw CacheFailure('error cached occurred');
  }
  final response = await client.delete(Uri.parse(Urls.deleteProductId(id)),
      headers: {'Authorization': 'Bearer $accessToken'});
  if (response.statusCode == 200) {
    return true;
  } else {
    throw ServerException();
  }
} on Exception catch (e) {
   print('An error occurred: $e');
    throw ServerException(); 
}
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    try {

      final accessToken = await userLocalDataSource.getAccessToken();
    if (accessToken == null) {
         throw CacheFailure('error cached occurred');
      }
  final response = await client.get(Uri.parse(Urls.getProductId(id)),headers: {'Authorization': 'Bearer $accessToken'});
  if (response.statusCode == 200) {
    return ProductModel.fromJson(json.decode(response.body)['data']);
  } else {
    throw ServerException();
  }
} on Exception catch (e) {
 print('An error occurred: $e');
    throw ServerException(); 
}
}


  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final accessToken = await userLocalDataSource.getAccessToken();
      if (accessToken == null) {
        throw CacheFailure('error cached occurred');
      }

      final response = await client.get(Uri.parse(Urls.getProducts),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw NetworkFailure('error occur');
      }

      List<dynamic> jsonDecoded = jsonDecode(response.body)['data'];
      final products = jsonDecoded
          .map((products) => ProductModel.fromJson(products))
          .toList();
      if (response.statusCode == 200) {
        return products;
      } else {
        throw ServerException();
      }
    } on Exception catch (e) {
      print('An error occurred: $e');
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final accessToken = await userLocalDataSource.getAccessToken();
      if (accessToken == null) {
        throw CacheFailure('error occurred');
      }
      final response = await client.put(
        Uri.parse(Urls.updateProductId(product.id)),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(json.decode(response.body)['data']);
      } else {
        throw ServerException();
      }
    } on Exception catch (e) {
      print('An error occurred: $e');
      throw ServerException();
    }
  }
}
