

import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/errormessage/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_sources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const Id = '1';

  group('get  products', () {
    test('should return  product model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.getProdcutById(Id),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_product_response.json'),
          200,
        ),
      );

      // act
      final result =await productRemoteDataSourceImpl.getProductById(Id);

      // assert

      expect(result, isA<ProductModel>());
    });

    test(
        'should throw a server exception  when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.getProdcutById(Id),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not found',
          404,
        ),
      );

      // act
      final result = productRemoteDataSourceImpl.getProductById(Id);

      // assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}