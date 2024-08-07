

import 'dart:io';

import '../../../../core/errormessage/exceptions.dart';
import '../../../../core/errormessage/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasources/local_data_sources.dart';
import '../datasources/remote_data_sources.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAll() async {
    try {
     final remoteProducts = await remoteDataSource.getAll();
        // Convert List<ProductModel> to List<ProductEntity>
        final productEntities = remoteProducts.map((product) {
          return ProductEntity(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
          );
        }).toList();
        return Right(productEntities);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      // final product = await remoteDataSource.getProductById(id);
      // return Right(product.toEntity());
       final remoteProduct = await remoteDataSource.getProductById(id);
        // Convert ProductModel to ProductEntity
        final productEntity = ProductEntity(
          id: remoteProduct.id,
          name: remoteProduct.name,
          description: remoteProduct.description,
          price: remoteProduct.price,
          imageUrl: remoteProduct.imageUrl,
        );
        return Right(productEntity);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }


  @override
  Future<Either<Failure, bool>> insertProduct(ProductEntity product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateProduct(ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}