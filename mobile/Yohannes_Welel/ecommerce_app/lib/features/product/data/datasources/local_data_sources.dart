



import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/errormessage/exceptions.dart';
import '../../../../core/errormessage/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';


abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> cacheProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final jsonString = sharedPreferences.getString(Urls.CACHED_PRODUCTS);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final products = await getAllProducts();
      return products.firstWhere((product) => product.id == id, orElse: () => throw CacheException());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final jsonList = products.map((product) => product.toJson()).toList();
      await sharedPreferences.setString(Urls.CACHED_PRODUCTS, json.encode(jsonList));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    try {
      final currentProducts = await getAllProducts();
      final updatedProducts = [...currentProducts, product];
      await cacheProducts(updatedProducts);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final products = await getAllProducts();
      final updatedProducts = products.where((product) => product.id != id).toList();
      await cacheProducts(updatedProducts);
    } catch (e) {
      throw CacheException();
    }
  }
}