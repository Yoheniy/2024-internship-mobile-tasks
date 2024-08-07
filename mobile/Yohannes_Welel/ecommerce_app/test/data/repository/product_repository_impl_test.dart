import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errormessage/exceptions.dart';
import 'package:ecommerce_app/core/errormessage/failure.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';



void main() {
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl repository;
  
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

  const testProductModel = ProductModel(
    id: '1',
    name: 'shoe',
    description: 'Nike shoes brand',
    price: 332.0,
    imageUrl: 'imagepath',
  );
   const testProductEntity = ProductEntity(
    id: '1',
    name: 'shoe',
    description: 'Nike shoes brand',
    price: 332.0,
    imageUrl: 'imagepath',
  );
  
  const testId = '1';
  group('get product by id', () {
    test('should return product when a call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getProductById(testId))
          .thenAnswer((_) async => testProductModel);
      // act
      final result = await repository.getProductById(testId);


      // assert
       verify(mockRemoteDataSource.getProductById(testId));
        expect(result, equals(const Right(testProductEntity)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getProductById(testId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getProductById(testId);

      // assert
      expect(
        result,
        equals(
          const Left(
            ServerFailure('An error has occurred'),
          ),
        ),
      );
    });

    test('should return connection failure when the device has no internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getProductById(testId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getProductById(testId);

      // assert
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

    test('should return server failure when a call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getAll()).thenThrow(ServerException());
      // act
      final result = await repository.getAll();
      // assert
      expect(result, equals(const Left(ServerFailure('An error has occurred'))));
    });

    test('should return connection failure when the device has no internet', () async {
      // arrange
      when(mockRemoteDataSource.getAll()).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAll();
      // assert
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAll())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAll();

      // assert
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });


}