import 'dart:convert';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 10.0,
  );

  const tProductJson = {
    'id': '1',
    'name': 'Test Product',
    'description': 'Test Description',
    'imageUrl': 'test_url',
    'price': 10.0,
  };

  test('should be a subclass of ProductEntity', () {
    // Assert
    expect(tProductModel, isA<ProductEntity>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // Arrange
      final jsonMap = json.decode(json.encode(tProductJson));

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result, tProductModel);
    });

  test('should handle malformed JSON by returning a ProductModel with default values', () {
  // Arrange
  final jsonMap = {'invalid_key': 'value'};

  // Act
  final result = ProductModel.fromJson(jsonMap);

  // Assert
  expect(result, isA<ProductModel>());
  expect(result.id, '');
  expect(result.name, '');
  expect(result.description, '');
  expect(result.imageUrl, '');
  expect(result.price, 0.0);
});

  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tProductModel.toJson();

      // Assert
      final expectedJsonMap = {
        'id': '1',
        'name': 'Test Product',
        'description': 'Test Description',
        'imageUrl': 'test_url',
        'price': 10.0,
      };
      expect(result, expectedJsonMap);
    });
  });

group('toEntity', () {
  test('should return a ProductEntity from ProductModel', () {
    // Act
    final result = tProductModel.toEntity();

    // Assert
    expect(result, isA<ProductEntity>());
    expect(result.id, tProductModel.id);
    expect(result.name, tProductModel.name);
    expect(result.description, tProductModel.description);
    expect(result.imageUrl, tProductModel.imageUrl);
    expect(result.price, tProductModel.price);
  });
});


  group('fromEntity', () {
    test('should return a ProductModel from ProductEntity', () {
      // Act
      final result = ProductModel.fromEntity(tProductModel);

      // Assert
      expect(result, tProductModel);
    });
  });
}
