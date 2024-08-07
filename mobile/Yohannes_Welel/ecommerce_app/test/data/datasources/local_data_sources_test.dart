import 'dart:convert';

import 'package:ecommerce_app/core/errormessage/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';




void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });




    const testProductModel = ProductModel(
      id: '1',
      name: 'Nike',
      description: 'new brand shoes',
      imageUrl: 'imagepath',
      price: 300.0);

 const cachedProduct = 'CACHED_PRODUCT';

  group('getProductById', () {
    test('should return ProductModel when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProduct))
          .thenReturn(json.encode(testProductModel.toJson()));
      // act
      final result = await dataSource.getProductById(testProductModel.id);
      // assert
      verify(mockSharedPreferences.getString(cachedProduct));
      expect(result, equals(testProductModel));
    });

  test('should throw a CacheException when the productToCache is null', () async {
      // act
      final call = dataSource.cacheProduct(productToCache: null);
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });




  group('cacheProduct', () {

    test('should throw a CacheException when the productToCache is null', () async {
      // act
      final call = dataSource.cacheProduct(productToCache: null);
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

 


}



