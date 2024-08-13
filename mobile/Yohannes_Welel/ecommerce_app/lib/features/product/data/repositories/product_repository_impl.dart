import 'package:dartz/dartz.dart';
import '../../../../core/errormessage/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_data_sources.dart';
import '../datasources/remote_data_sources.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        return remoteProducts.fold(
          (failure) => Left(failure),
          (products) {
            localDataSource.cacheProducts(products);
            return Right(products.map((model) => model.toEntity()).toList());
          },
        );
      } catch (e) {
        return const Left(ServerFailure('Failed to fetch products from remote server'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getAllProducts();
        return Right(localProducts.map((model) => model.toEntity()).toList());
      } catch (e) {
        return const Left(CacheFailure('Failed to fetch products from cache'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProductById(id);
        return remoteProduct.fold(
          (failure) => Left(failure),
          (product) {
            localDataSource.cacheProduct(product);
            return Right(product.toEntity());
          },
        );
      } catch (e) {
        return const Left(ServerFailure('Failed to fetch product from remote server'));
      }
    } else {
      try {
        final localProduct = await localDataSource.getProductById(id);
        return Right(localProduct.toEntity());
      } catch (e) {
        return const Left(CacheFailure('Failed to fetch product from cache'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    final productModel = ProductModel.fromEntity(product);
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.createProduct(productModel);
        return result;
      } catch (e) {
        return const Left(ServerFailure('Failed to create product on remote server'));
      }
    } else {
      return const Left(ConnectionFailure('No network connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    final productModel = ProductModel.fromEntity(product);
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateProduct(productModel);
        return result;
      } catch (e) {
        return const Left(ServerFailure('Failed to update product on remote server'));
      }
    } else {
      return const Left(ConnectionFailure('No network connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteProduct(id);
        if (result.isRight()) {
          await localDataSource.deleteProduct(id);
        }
        return result;
      } catch (e) {
        return const Left(ServerFailure('Failed to delete product on remote server'));
      }
    } else {
      return const Left(ConnectionFailure('No network connection'));
    }
  }
}

