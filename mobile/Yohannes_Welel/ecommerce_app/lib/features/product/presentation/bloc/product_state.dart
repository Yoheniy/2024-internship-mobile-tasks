part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class InitialState extends ProductState {}

final class LoadingState extends ProductState {}

final class LoadedAllProductState extends ProductState {
  final List<ProductModel> allProducts;

  const LoadedAllProductState({required this.allProducts});
}

final class LoadedSingleProductState extends ProductState {
  final ProductEntity productEntity;

  const LoadedSingleProductState(this.productEntity);
}

final class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);
}