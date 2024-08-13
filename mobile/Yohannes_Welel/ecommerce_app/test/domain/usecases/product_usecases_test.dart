import 'package:ecommerce_app/core/errormessage/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usescase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product_usescase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late MockProductRepository mockProductRepository;
  late CreateProductUsecase createProductUsecase;
  late UpdateProductUsecase updateProductUsecase;
  late DeleteProductUsecase deleteProductUsecase;
  late GetProductUsecase getProductUsecases;
  late GetAllProductUsecase getAllProductUsecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    createProductUsecase = CreateProductUsecase(mockProductRepository);
    updateProductUsecase = UpdateProductUsecase(mockProductRepository);
    deleteProductUsecase = DeleteProductUsecase(mockProductRepository);
    getProductUsecases = GetProductUsecase(mockProductRepository);
    getAllProductUsecase = GetAllProductUsecase(mockProductRepository);
  });

  const tProduct = ProductEntity(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test_url',
    price: 10.0,
  );

  final tProductList = <ProductEntity>[tProduct];

  group('CreateProductUsecase', () {
    test('should create a new product successfully', () async {
      // Arrange
      when(mockProductRepository.createProduct(any))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await createProductUsecase.execute(tProduct);

      // Assert
      expect(result, Right(null));
      verify(mockProductRepository.createProduct(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a failure when creating a product fails', () async {
      // Arrange
      when(mockProductRepository.createProduct(any))
          .thenAnswer((_) async => Left(CacheFailure('Failed to create product')));

      // Act
      final result = await createProductUsecase.execute(tProduct);

      // Assert
      expect(result, Left(CacheFailure('Failed to create product')));
      verify(mockProductRepository.createProduct(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });

  group('UpdateProductUsecase', () {
    test('should update an existing product successfully', () async {
      // Arrange
      when(mockProductRepository.updateProduct(any))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await updateProductUsecase.execute(tProduct);

      // Assert
      expect(result, Right(null));
      verify(mockProductRepository.updateProduct(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a failure when updating a product fails', () async {
      // Arrange
      when(mockProductRepository.updateProduct(any))
          .thenAnswer((_) async => Left(CacheFailure('Failed to update product')));

      // Act
      final result = await updateProductUsecase.execute(tProduct);

      // Assert
      expect(result, Left(CacheFailure('Failed to update product')));
      verify(mockProductRepository.updateProduct(tProduct));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });

  group('DeleteProductUsecase', () {
    test('should delete a product successfully', () async {
      // Arrange
      when(mockProductRepository.deleteProduct(any))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await deleteProductUsecase.execute('1');

      // Assert
      expect(result, Right(null));
      verify(mockProductRepository.deleteProduct('1'));
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a failure when deleting a product fails', () async {
      // Arrange
      when(mockProductRepository.deleteProduct(any))
          .thenAnswer((_) async => Left(CacheFailure('Failed to delete product')));

      // Act
      final result = await deleteProductUsecase.execute('1');

      // Assert
      expect(result, Left(CacheFailure('Failed to delete product')));
      verify(mockProductRepository.deleteProduct('1'));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });

  group('GetProductUsecases', () {
    test('should get a product by id successfully', () async {
      // Arrange
      when(mockProductRepository.getProductById(any))
          .thenAnswer((_) async => Right(tProduct));

      // Act
      final result = await getProductUsecases.execute('1');

      // Assert
      expect(result, Right(tProduct));
      verify(mockProductRepository.getProductById('1'));
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a failure when getting a product by id fails', () async {
      // Arrange
      when(mockProductRepository.getProductById(any))
          .thenAnswer((_) async => Left(ServerFailure('Failed to get product')));

      // Act
      final result = await getProductUsecases.execute('1');

      // Assert
      expect(result, Left(ServerFailure('Failed to get product')));
      verify(mockProductRepository.getProductById('1'));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });

  group('GetAllProductUsecase', () {
    test('should get all products successfully', () async {
      // Arrange
      when(mockProductRepository.getAllProducts())
          .thenAnswer((_) async => Right(tProductList));

      // Act
      final result = await getAllProductUsecase.execute();

      // Assert
      expect(result, Right(tProductList));
      verify(mockProductRepository.getAllProducts());
      verifyNoMoreInteractions(mockProductRepository);
    });

    test('should return a failure when getting all products fails', () async {
      // Arrange
      when(mockProductRepository.getAllProducts())
          .thenAnswer((_) async => Left(ServerFailure('Failed to get products')));

      // Act
      final result = await getAllProductUsecase.execute();

      // Assert
      expect(result, Left(ServerFailure('Failed to get products')));
      verify(mockProductRepository.getAllProducts());
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
