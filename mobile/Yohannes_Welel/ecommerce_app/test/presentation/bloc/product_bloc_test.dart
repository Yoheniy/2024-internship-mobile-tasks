import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errormessage/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetProductUsecase mockGetProductUsecase;
  late MockGetAllProductUsecase mockGetAllProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late ProductBloc productBloc;

  setUp(() {
    mockGetProductUsecase = MockGetProductUsecase();
    mockGetAllProductUsecase = MockGetAllProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();

    productBloc = ProductBloc(
      mockGetProductUsecase,
      mockGetAllProductUsecase,
      mockUpdateProductUsecase,
      mockDeleteProductUsecase,
      mockCreateProductUsecase,
     
    );
  });

  const testProductEntity = ProductEntity(
      id: '6672752cbd218790438efdb0',
      name: 'Anime website',
      description: 'Explore anime characters.',
      price: 123,
      imageUrl:
          "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg");

  const testProductId = '6672752cbd218790438efdb0';

  test('initial state should be empty', () {
    expect(productBloc.state, InitialState());
  });

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, GetProducts] when data is gotten successfully',
      build: () {
        when(mockGetProductUsecase.execute(testProductId))
            .thenAnswer((_) async => const Right(testProductEntity));
        return productBloc;
      },
      act: (bloc) => bloc.add( GetSingleProductEvent(testProductId)),
      expect: () =>
          [LoadingState(), const LoadedSingleProductState(testProductEntity)]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, GetAllProducts] when data is gotten successfully',
      build: () {
        when(mockGetAllProductUsecase.execute())
            .thenAnswer((_) async => const Right([]));
        return productBloc;
      },
      act: (bloc) => bloc.add( LoadAllProductEvent()),
      expect: () =>
          [LoadingState(), const LoadedAllProductState(allProducts: [])]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, GetAllProducts] when data is gotten successfully',
      build: () {
        when(mockGetAllProductUsecase.execute())
            .thenAnswer((_) async => const Right([]));
        return productBloc;
      },
      act: (bloc) => bloc.add( LoadAllProductEvent()),
      expect: () =>
          [LoadingState(), const LoadedAllProductState(allProducts: [])]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading] when Delete successful',
      build: () {
        when(mockDeleteProductUsecase.execute(testProductId))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(testProductId)),
      expect: () => [LoadingState()]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading] when Update successful',
      build: () {
        when(mockUpdateProductUsecase.execute(testProductEntity))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateProductEvent(testProductEntity)),
      expect: () => [LoadingState()]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading] when insert successful',
      build: () {
        when(mockCreateProductUsecase.execute(testProductEntity))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(testProductEntity)),
      expect: () => [LoadingState()]);

  blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetProductUsecase.execute(testProductId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(testProductId)),
      expect: () => [
            LoadingState(),
            const ErrorState('Server failure'),
          ]);
}
