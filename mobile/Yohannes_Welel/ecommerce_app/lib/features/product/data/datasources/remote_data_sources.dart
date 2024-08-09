import 'dart:convert'; // Import for JSON decoding
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/errormessage/failure.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, ProductModel>> getProductById(String id);
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, void>> createProduct(ProductModel product);
  Future<Either<Failure, void>> updateProduct(ProductModel product);
  Future<Either<Failure, void>> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, ProductModel>> getProductById(String id) async {
    try {
      final response = await client.get(Uri.parse(Urls.getSingleProdcut(id)));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final product = ProductModel.fromJson(jsonResponse);
        return Right(product);
      } else {
        return Left(ServerFailure('Failed to load product'));
      }
    } catch (_) {
      return Left(ServerFailure('Failed to load product'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final response = await client.get(Uri.parse(Urls.allProductUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final products = jsonResponse.map((item) => ProductModel.fromJson(item)).toList();
        return Right(products);
      } else {
        return Left(ServerFailure('Failed to load products'));
      }
    } catch (_) {
      return Left(ServerFailure('Failed to load products'));
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductModel product) async {
    try {
      final response = await client.post(
        Uri.parse(Urls.allProductUrl),
        headers: Urls.jsonHeader,
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed to create product'));
      }
    } catch (_) {
      return Left(ServerFailure('Failed to create product'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel product) async {
    try {
      final response = await client.put(
        Uri.parse(Urls.getSingleProdcut(product.id)),
        headers: Urls.jsonHeader,
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed to update product'));
      }
    } catch (_) {
      return Left(ServerFailure('Failed to update product'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      final response = await client.delete(Uri.parse(Urls.getSingleProdcut(id)));
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed to delete product'));
      }
    } catch (_) {
      return Left(ServerFailure('Failed to delete product'));
    }
  }
}
