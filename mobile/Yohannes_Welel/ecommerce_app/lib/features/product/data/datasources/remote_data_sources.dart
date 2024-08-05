import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';

import '../../../../core/errormessage/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAll();
  Future<ProductModel> getProductById(String id);

  Future<bool> insertProduct(ProductModel product);

  Future<bool> updateProduct(ProductModel product);

  Future<bool> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      Uri.parse(
        Urls.getProdcutById(id.toString()),
      ),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException('server not found');
    }
  }

  @override
  Future<bool> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> insertProduct(ProductModel product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
  

}