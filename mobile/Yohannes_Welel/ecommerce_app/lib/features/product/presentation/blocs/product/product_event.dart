part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
class LoadAllProductEvent extends ProductEvent{
  @override
  List<Object> get props => [];
}

class LoadSingleProductEvent extends ProductEvent{
  final String id;

  const LoadSingleProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
class UpdateProductEvent extends ProductEvent{
  final ProductEntity product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent{
  final String id;

  const DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
class CreateProductEvent extends ProductEvent{
  final ProductEntity product;

  const CreateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}