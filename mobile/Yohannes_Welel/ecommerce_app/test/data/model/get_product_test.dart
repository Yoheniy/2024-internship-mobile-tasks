import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
  const testProductModel = ProductModel(
      id: '1',
      name: 'Nike',
      description: 'new brand shoes',
      imageUrl: 'imagepath',
      price: 300.0);

  test('should be a subclass of get_product entitiy', () async {
    //assert
    expect(testProductModel, isA<ProductEntity>());
  });

  test('the mode that come from the test have to be similar with the model we create here its testGetProductModel', 
  () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_product_response.json'),
    );
    //assert

    final result = ProductModel.fromJson(jsonMap);
    expect(result, equals(testProductModel));
  });

  test('converting object to json format', () async {
    //arrange
    final result = testProductModel.toJson();

    //assert
    final expectedJsonMap = {
      'id': '1',
      'name': 'Nike',
      'description': 'new brand shoes',
      'imageUrl': 'imagepath',
      'price': 300.0
    };
    expect(result, equals(expectedJsonMap));
  });
}
