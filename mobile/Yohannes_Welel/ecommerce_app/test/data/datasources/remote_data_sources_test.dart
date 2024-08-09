import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/features/product/data/datasources/remote_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/core/errormessage/failure.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProductById', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );

    test('should return ProductModel when the response code is 200', () async {
      // Arrange
      final jsonResponse = json.encode(tProductModel.toJson());
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      // Act
      final result = await dataSource.getProductById('1');

      // Assert
      expect(result, Right(tProductModel));
      verify(mockHttpClient.get(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when the response code is 404 or other', () async {
      // Arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final result = await dataSource.getProductById('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to load product')));
      verify(mockHttpClient.get(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when an exception is thrown', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenThrow(Exception());

      // Act
      final result = await dataSource.getProductById('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to load product')));
      verify(mockHttpClient.get(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('getAllProducts', () {
    final tProductModels = <ProductModel>[
      ProductModel(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 10.0,
        imageUrl: 'test_url',
      ),
    ];

  test('should return List<ProductModel> when the response code is 200', () async {
    // Arrange
    final jsonResponse = json.encode(tProductModels.map((model) => model.toJson()).toList());
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response(jsonResponse, 200));

    // Act
    final result = await dataSource.getAllProducts();

    // Assert
    expect(result, isA<Right<Failure, List<ProductModel>>>()
      .having((r) => r.getOrElse(() => []), 'data', tProductModels));
    verify(mockHttpClient.get(Uri.parse(Urls.allProductUrl)));
    verifyNoMoreInteractions(mockHttpClient);
  });



    test('should return ServerFailure when the response code is 404 or other', () async {
      // Arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      expect(result, Left(ServerFailure('Failed to load products')));
      verify(mockHttpClient.get(Uri.parse(Urls.allProductUrl)));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when an exception is thrown', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenThrow(Exception());

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      // expect(result, isA<Left<Failure, List<ProductModel>>>();
      expect(result, Left(ServerFailure('Failed to load products')));
      verify(mockHttpClient.get(Uri.parse(Urls.allProductUrl)));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('createProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );

    test('should return void when the response code is 201', () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 201));

      // Act
      final result = await dataSource.createProduct(tProductModel);

      // Assert
      expect(result, Right(null));
      verify(mockHttpClient.post(
        Uri.parse(Urls.allProductUrl),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when the response code is 400 or other', () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act
      final result = await dataSource.createProduct(tProductModel);

      // Assert
      expect(result, Left(ServerFailure('Failed to create product')));
      verify(mockHttpClient.post(
        Uri.parse(Urls.allProductUrl),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when an exception is thrown', () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception());

      // Act
      final result = await dataSource.createProduct(tProductModel);

      // Assert
      expect(result, Left(ServerFailure('Failed to create product')));
      verify(mockHttpClient.post(
        Uri.parse(Urls.allProductUrl),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('updateProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );

    test('should return void when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await dataSource.updateProduct(tProductModel);

      // Assert
      expect(result, Right(null));
      verify(mockHttpClient.put(
        Uri.parse(Urls.getSingleProdcut(tProductModel.id)),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when the response code is 400 or other', () async {
      // Arrange
      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act
      final result = await dataSource.updateProduct(tProductModel);

      // Assert
      expect(result, Left(ServerFailure('Failed to update product')));
      verify(mockHttpClient.put(
        Uri.parse(Urls.getSingleProdcut(tProductModel.id)),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when an exception is thrown', () async {
      // Arrange
      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception());

      // Act
      final result = await dataSource.updateProduct(tProductModel);

      // Assert
      expect(result, Left(ServerFailure('Failed to update product')));
      verify(mockHttpClient.put(
               Uri.parse(Urls.getSingleProdcut(tProductModel.id)),
        headers: Urls.jsonHeader,
        body: json.encode(tProductModel.toJson()),
      ));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('deleteProduct', () {
    test('should return void when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.delete(any))
          .thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await dataSource.deleteProduct('1');

      // Assert
      expect(result, Right(null));
      verify(mockHttpClient.delete(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when the response code is 400 or other', () async {
      // Arrange
      when(mockHttpClient.delete(any))
          .thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act
      final result = await dataSource.deleteProduct('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to delete product')));
      verify(mockHttpClient.delete(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('should return ServerFailure when an exception is thrown', () async {
      // Arrange
      when(mockHttpClient.delete(any)).thenThrow(Exception());

      // Act
      final result = await dataSource.deleteProduct('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to delete product')));
      verify(mockHttpClient.delete(Uri.parse(Urls.getSingleProdcut('1'))));
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
