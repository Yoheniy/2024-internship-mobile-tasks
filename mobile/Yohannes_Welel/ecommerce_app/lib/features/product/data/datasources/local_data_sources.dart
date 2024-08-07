import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/errormessage/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource{
  Future<ProductModel?> getProductById(String id);
  Future<List<ProductModel>> getAll();
  Future<bool>insertProduct(ProductModel product);
  Future<bool>deleteProduct(String id);
  Future<bool>updateProduct(ProductModel product);

   
}


class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  late final http.Client client;

  ProductLocalDataSourceImpl({required this.client});

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
      throw ServerException();
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
