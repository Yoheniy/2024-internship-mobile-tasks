import 'dart:convert';

import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/errormessage/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(mockSharedPreferences);
  });

  group('cacheProducts', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );
    final List<ProductModel> tProductModels = [tProductModel];

    test('should cache products', () async {
      // Arrange
      final jsonString = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.setString(Urls.CACHED_PRODUCTS, jsonString))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheProducts(tProductModels);

      // Assert
      verify(mockSharedPreferences.setString(
        Urls.CACHED_PRODUCTS,
        jsonString,
      ));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when caching fails', () async {
      // Arrange
      final jsonString = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.setString(Urls.CACHED_PRODUCTS, jsonString))
          .thenThrow(Exception('Failed to cache'));

      // Act
      final call = dataSource.cacheProducts(tProductModels);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('getAllProducts', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );
    final List<ProductModel> tProductModels = [tProductModel];

    test('should return list of products from cache', () async {
      // Arrange
      final jsonString = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(jsonString);

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      expect(result, equals(tProductModels));
      verify(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when there is no cached data', () async {
      // Arrange
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(null);

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });

    test('should throw CacheException when decoding fails', () async {
      // Arrange
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn('not a json string');

      // Act
      final call = dataSource.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('getProductById', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );
    final List<ProductModel> tProductModels = [tProductModel];

    test('should return a product by id', () async {
      // Arrange
      final jsonString = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(jsonString);

      // Act
      final result = await dataSource.getProductById('1');

      // Assert
      expect(result, equals(tProductModel));
    });

    test('should throw CacheException when product is not found', () async {
      // Arrange
      final jsonString = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(jsonString);

      // Act
      final call = dataSource.getProductById;

      // Assert
      expect(() => call('2'), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );

    test('should cache a single product', () async {
  // Arrange
  final existingProductsJson = json.encode([]);
  final updatedProductsJson = json.encode([tProductModel.toJson()]);
  
  when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
      .thenReturn(existingProductsJson);
  when(mockSharedPreferences.setString(Urls.CACHED_PRODUCTS, updatedProductsJson))
      .thenAnswer((_) async => true);

  // Act
  await dataSource.cacheProduct(tProductModel);

  // Assert
  verify(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS));
  verify(mockSharedPreferences.setString(
    Urls.CACHED_PRODUCTS,
    updatedProductsJson,
  ));
  verifyNoMoreInteractions(mockSharedPreferences);
});


    test('should throw CacheException when caching fails', () async {
      // Arrange
      final existingProductsJson = json.encode([]);
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(existingProductsJson);
      when(mockSharedPreferences.setString(any, any))
          .thenThrow(Exception('Failed to cache'));

      // Act
      final call = dataSource.cacheProduct;

      // Assert
      expect(() => call(tProductModel), throwsA(isA<CacheException>()));
    });
  });

  group('deleteProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 10.0,
      imageUrl: 'test_url',
    );
    final List<ProductModel> tProductModels = [tProductModel];

     test('should delete a product by id', () async {
      // Arrange
      final existingProductsJson = json.encode(tProductModels.map((model) => model.toJson()).toList());
      final updatedProductsJson = json.encode([]); // Expected JSON after deletion
      
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(existingProductsJson);
      when(mockSharedPreferences.setString(Urls.CACHED_PRODUCTS, updatedProductsJson))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.deleteProduct('1');

      // Assert
      verify(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS)).called(1);
      verify(mockSharedPreferences.setString(
        Urls.CACHED_PRODUCTS,
        updatedProductsJson,
      )).called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when deleting fails', () async {
      // Arrange
      final existingProductsJson = json.encode(tProductModels.map((model) => model.toJson()).toList());
      when(mockSharedPreferences.getString(Urls.CACHED_PRODUCTS))
          .thenReturn(existingProductsJson);
      when(mockSharedPreferences.setString(any, any))
          .thenThrow(Exception('Failed to delete'));

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call('1'), throwsA(isA<CacheException>()));
    });
  });
}