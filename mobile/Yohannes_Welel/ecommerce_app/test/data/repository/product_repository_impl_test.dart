// import 'package:dartz/dartz.dart';
// import 'package:ecommerce_app/core/errormessage/exceptions.dart';
// import 'package:ecommerce_app/core/errormessage/failure.dart';
// import 'package:ecommerce_app/features/product/data/datasources/remote_data_sources.dart';
// import 'package:ecommerce_app/features/product/data/models/product_model.dart';
// import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

// void main() {
//   late MockRemoteDataSource mockRemoteDataSource;
//   late ProductRepositoryImpl repository;

//   setUp(() {
//     mockRemoteDataSource = MockRemoteDataSource();
//     repository = ProductRepositoryImpl(remoteDataSource: mockRemoteDataSource);
//   });

//   group('getAll', () {
//     final productModel = ProductModel(
//       id: 1,
//       name: 'Nike',
//       description: 'new brand shoes',
//       imageUrl: 'imagepath',
//       price: 300.0,
//     );

//     test('should return List<ProductEntity> when the call is successful', () async {
//       when(mockRemoteDataSource.getAll()).thenAnswer(
//         (_) async => [productModel],
//       );

//       final result = await repository.getAll();

//       expect(result, Right([productModel.toEntity()]));
//     });

//     test('should return Failure when the call is unsuccessful', () async {
//       when(mockRemoteDataSource.getAll()).thenThrow(ServerException('server is not found'));

//       final result = await repository.getAll();

//       expect(result, Left(ServerFailure('Server failure', message: 'server is not found')));
//     });
//   });

//   // Similarly, add tests for other methods like getProductById, insertProduct, etc.
// }
