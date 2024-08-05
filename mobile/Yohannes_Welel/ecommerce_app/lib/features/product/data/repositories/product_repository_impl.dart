



//   // lib/features/product/data/repositories/product_repository_impl.dart
// // lib/features/product/data/repositories/product_repository_impl.dart


// import 'package:dartz/dartz.dart';

// import '../../../../core/errormessage/failure.dart';
// import '../../domain/entities/product_entity.dart';
// import '../../domain/repositories/product_repository.dart';
// import '../datasources/remote_data_sources.dart';
// import '../models/product_model.dart';

// class ProductRepositoryImpl implements ProductRepository {
//   final ProductRemoteDataSource remoteDataSource;

//   ProductRepositoryImpl({required this.remoteDataSource});

//   @override
// Future<Either<Failure, List<ProductEntity>>> getAll() async {
//   try {
//     final productModels = await remoteDataSource.getAll();
//     final products = productModels.map((model) => model.toEntity()).toList();
//     return Right(products);
//   } catch (e) {
//     return Left(ServerFailure('Server failure', message: e.toString()));
//   }
// }


//   @override
//   Future<Either<Failure, ProductEntity>> getProductById(String id) async {
//     try {
//       final productModel = await remoteDataSource.getProductById(id);
//       return Right(productModel.toEntity());
//     } catch (e) {
//      return Left(ServerFailure('Server failure', message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> insertProduct(ProductEntity product) async {
//     try {
//       final productModel = ProductModel(
//         id: product.id,
//         name: product.name,
//         description: product.description,
//         imageUrl: product.imageUrl,
//         price: product.price,
//       );
//       await remoteDataSource.insertProduct(productModel);
//       return 
//     } catch (e) {
//    return Left(ServerFailure('Server failure', message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> updateProduct(ProductEntity product) async {
//     try {
//       final productModel = ProductModel(
//         id: product.id,
//         name: product.name,
//         description: product.description,
//         imageUrl: product.imageUrl,
//         price: product.price,
//       );
//       await remoteDataSource.updateProduct(productModel);
//       return const Right(null);
//     } catch (e) {
//    return Left(ServerFailure('Server failure', message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteProduct(int id) async {
//     try {
//       await remoteDataSource.deleteProduct(id);
//       return const Right(null);
//     } catch (e) {
//    return Left(ServerFailure('Server failure', message: e.toString()));
//     }
//   }
// }
