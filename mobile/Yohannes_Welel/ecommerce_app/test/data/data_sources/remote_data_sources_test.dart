
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/features/product/data/data_sources/remote/remote_data_source_impl.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helper/dummy_data/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;
  // late UserLocalDataSourceImpl userLocalDataSource;
  late MockUserLocalDataSource userLocalDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userLocalDataSource=MockUserLocalDataSource();
    remoteDataSourceImpl = RemoteDataSourceImpl(client: mockHttpClient, userLocalDataSource: userLocalDataSource);
  });
  const String productsResponsePath =
      '/helper/dummy_data/dummy_products_GET_response.json';
  const String id = '6672776eb905525c145fe0bb';
  const String getProductResponsePath =
      '/helper/dummy_data/dummy_product_GET_response.json';
  const String deleteProductResponsePath =
      '/helper/dummy_data/dummy_product_DELETE_response.json';
  const String updateProductResponsePath =
      '/helper/dummy_data/dummy_product_GET_response.json';
  const tProductModel = ProductModel(
    id: '6672776eb905525c145fe0bb',
    name: 'Anime website',
    description: 'Explore anime characters.',
    price: 123,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777711/images/clmxnecvavxfvrz9by4w.jpg',
  );
  List<ProductModel> tProductList = [
    const ProductModel(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg',
    ),
    const ProductModel(
      id: '66728788b116d7a8d476558c',
      name: 'Better name',
      description: 'Even better description. The best description ever.',
      price: 112,
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718781833/images/jxt6xd4ivavvuodt9gkx.jpg',
    ),
  ];


  group('get a product', () {
    test('should return a product model if the response is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProductId(id)))).thenAnswer(
          (_) async => http.Response(
              readJson(getProductResponsePath),
              200));
      //act
      final result = await remoteDataSourceImpl.getProduct(id);
      //assert

      expect(result, tProductModel);
    });

    test('Should throw a server exception if the response is 404', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProductId(id))))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act and assert

      expect(() async {
        await remoteDataSourceImpl.getProduct(id);
      }, throwsA(isA<Exception>()));
    });
  });

  group('get All products', () {
    test('should return a List of products  if the response is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProducts))).thenAnswer(
          (_) async => http.Response(
              readJson(productsResponsePath),
              200));
      //act
      final result = await remoteDataSourceImpl.getProducts();
      //assert

      expect(result, tProductList);
    });

    test('Should throw a server exception if the response is 404', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProducts)))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act and assert

      expect(() async {
        await remoteDataSourceImpl.getProducts();
      }, throwsA(isA<Exception>()));
    });
  });

  group('delete a product', () {
    test('should return true if the response is 200', () async {
      //arrange
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProductId(id))))
          .thenAnswer((_) async => http.Response(
              readJson(deleteProductResponsePath),
              200));
      //act
      final result = await remoteDataSourceImpl.deleteProduct(id);
      //assert
      expect(result, true);
    });

    test('Should throw a server exception if the response is 404', () async {
      //arrange
      when(mockHttpClient.delete(Uri.parse(Urls.deleteProductId(id))))
          .thenAnswer((_) async => http.Response('Operation Failed', 404));
      //act
      //assert
      expect(() async {
        await remoteDataSourceImpl.deleteProduct(id);
      }, throwsA(isA<Exception>()));
    });
  });

  group('update a product', () {
    test('should return the updated product if the response is 200', () async {
      //arrange
      when(mockHttpClient.put(Uri.parse(Urls.updateProductId(id)),
              body: tProductModel.toJson()))
          .thenAnswer((_) async => http.Response(
              readJson(updateProductResponsePath),
              200));
      //act
      final result = await remoteDataSourceImpl.updateProduct(tProductModel);
      //assert
      expect(result, tProductModel);
    });

    test('Should throw a server exception if the response is 404', () async {
      //arrange
      when(mockHttpClient.put(Uri.parse(Urls.deleteProductId(id)),
              body: tProductModel.toJson()))
          .thenAnswer((_) async => http.Response('Operation Failed', 404));
      //act
      //assert
      expect(() async {
        await remoteDataSourceImpl.updateProduct(tProductModel);
      }, throwsA(isA<Exception>()));
    });
  });
}
