
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errormessage/exceptions.dart';
import 'package:ecommerce_app/core/errormessage/failure.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';


void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 10.0,
    imageUrl: 'test_url',
  );
  final tProductEntity = tProductModel.toEntity();
  final List<ProductModel> tProductModels = [tProductModel];
  final List<ProductEntity> tProductEntities = [tProductEntity];

  group('getAllProducts', () {
    test('should return remote products when the network is connected', () async {
    // Arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemoteDataSource.getAllProducts())
        .thenAnswer((_) async => Right(tProductModels));
    when(mockLocalDataSource.cacheProducts(any)).thenAnswer((_) async => {});

    // Act
    final result = await repository.getAllProducts();

    // Assert
    expect(result, isA<Right<Failure, List<ProductEntity>>>()
      .having((right) => right.value, 'value', tProductEntities));
    verify(mockRemoteDataSource.getAllProducts());
    verify(mockLocalDataSource.cacheProducts(tProductModels));
    verifyNoMoreInteractions(mockRemoteDataSource);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
test('should return cached products when the network is not connected', () async {
    // Arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(mockLocalDataSource.getAllProducts()).thenAnswer((_) async => tProductModels);

    // Act
    final result = await repository.getAllProducts();

    // Assert
    expect(result, isA<Right<Failure, List<ProductEntity>>>()
      .having((right) => right.value, 'value', tProductEntities));
    verify(mockLocalDataSource.getAllProducts());
    verifyNoMoreInteractions(mockLocalDataSource);
  });
    test('should return failure when getting remote products fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Left(ServerFailure('Failed to fetch products')));

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, Left(ServerFailure('Failed to fetch products')));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when cache fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Right(tProductModels));
      when(mockLocalDataSource.cacheProducts(any)).thenThrow(Exception());

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, Left(ServerFailure('Failed to fetch products from remote server')));
      verify(mockRemoteDataSource.getAllProducts());
      verify(mockLocalDataSource.cacheProducts(tProductModels));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('getProductById', () {
    test('should return remote product when the network is connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById('1'))
          .thenAnswer((_) async => Right(tProductModel));
      when(mockLocalDataSource.cacheProduct(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.getProductById('1');

      // Assert
      expect(result, Right(tProductEntity));
      verify(mockRemoteDataSource.getProductById('1'));
      verify(mockLocalDataSource.cacheProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return cached product when the network is not connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getProductById('1')).thenAnswer((_) async => tProductModel);

      // Act
      final result = await repository.getProductById('1');

      // Assert
      expect(result, Right(tProductEntity));
      verify(mockLocalDataSource.getProductById('1'));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when getting remote product fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById('1'))
          .thenAnswer((_) async => Left(ServerFailure('Failed to fetch product')));

      // Act
      final result = await repository.getProductById('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to fetch product')));
      verify(mockRemoteDataSource.getProductById('1'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when getting cached product fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getProductById('1')).thenThrow(CacheException());

      // Act
      final result = await repository.getProductById('1');

      // Assert
      expect(result, Left(CacheFailure('Failed to fetch product from cache')));
      verify(mockLocalDataSource.getProductById('1'));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('createProduct', () {
    test('should return success when the network is connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(any))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await repository.createProduct(tProductEntity);

      // Assert
      expect(result, Right(null));
      verify(mockRemoteDataSource.createProduct(tProductModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return failure when the network is not connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.createProduct(tProductEntity);

      // Assert
      expect(result, Left(ConnectionFailure('No network connection')));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
    });

  //  test('should return failure when creating a product fails', () async {
  //     // Arrange
  //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  //     when(mockRemoteDataSource.createProduct(any))
  //         .thenAnswer((_) async => Left(ServerFailure('Failed to create product')));

  //     // Act
  //     final result = await repository.createProduct(tProductEntity);

  //     // Assert
  //     expect(result, Left(ServerFailure('Failed to create product on remote server')));
  //     verify(mockRemoteDataSource.createProduct(tProductModel));
  // });

  group('updateProduct', () {
    test('should return success when the network is connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(any))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await repository.updateProduct(tProductEntity);

      // Assert
      expect(result, Right(null));
      verify(mockRemoteDataSource.updateProduct(tProductModel));
     verifyNoMoreInteractions(mockRemoteDataSource);

    });



    test('should return failure when the network is not connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.updateProduct(tProductEntity);

      // Assert
      expect(result, Left(ConnectionFailure('No network connection')));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
// test('should return failure when updating a product fails', () async {
//   // Arrange
//   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//   when(mockRemoteDataSource.updateProduct(any))
//       .thenAnswer((_) async => Left(ServerFailure('Failed to update product')));

//   // Act
//   final result = await repository.updateProduct(tProductEntity);

//   // Assert
//   expect(result, isA<Left<ServerFailure, void>>()
//     .having((failure) => failure.value.message, 'message', 'Failed to update product on remote server'));
//   verify(mockRemoteDataSource.updateProduct(ProductModel.fromEntity(tProductEntity)));
//   verifyNoMoreInteractions(mockRemoteDataSource);
// });

  });

  group('deleteProduct', () {
    test('should return success when the network is connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct('1'))
          .thenAnswer((_) async => Right(null));
      when(mockLocalDataSource.deleteProduct('1')).thenAnswer((_) async => {});

      // Act
      final result = await repository.deleteProduct('1');

      // Assert
      expect(result, Right(null));
      verify(mockRemoteDataSource.deleteProduct('1'));
      verify(mockLocalDataSource.deleteProduct('1'));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return failure when the network is not connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.deleteProduct('1');

      // Assert
      expect(result, Left(ConnectionFailure('No network connection')));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

  test('should return failure when deleting a product fails', () async {
  // Arrange
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  when(mockRemoteDataSource.deleteProduct('1'))
      .thenAnswer((_) async => Left(ServerFailure('Failed to delete product')));

  // Act
  final result = await repository.deleteProduct('1');

  // Assert
  expect(result, Left(ServerFailure('Failed to delete product')));
  verify(mockRemoteDataSource.deleteProduct('1'));
  verifyNoMoreInteractions(mockRemoteDataSource);
});

  });
}

