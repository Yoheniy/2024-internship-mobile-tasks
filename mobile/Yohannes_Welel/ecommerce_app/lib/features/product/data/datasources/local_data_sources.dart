import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errormessage/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource{
  Future<void> cacheProduct({required ProductModel? productToCache});
  Future<ProductModel?> getProductById(String id);
  Future<List<ProductModel>> getAll();
  Future<bool>insertProduct(ProductModel product);
  Future<bool>deleteProduct(String id);
  Future<bool>updateProduct(ProductModel product);


   
}
const cachedProduct = 'CACHED_PRODUCT';

class ProductLocalDataSourceImpl extends ProductLocalDataSource {

  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductById(String id){
   final jsonString = sharedPreferences.getString(cachedProduct);

    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
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
  
  @override
  Future<void> cacheProduct({required ProductModel? productToCache}) async{
    if (productToCache != null) {
      sharedPreferences.setString(
        cachedProduct,
        json.encode(
          productToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}


