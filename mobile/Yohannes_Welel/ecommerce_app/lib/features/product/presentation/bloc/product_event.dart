part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductEvent {}

class GetSingleProductEvent extends ProductEvent {
  String id;
  GetSingleProductEvent(this.id);
}

class UpdateProductEvent extends ProductEvent {
  ProductEntity productEntity;
  UpdateProductEvent(this.productEntity);
}

class DeleteProductEvent extends ProductEvent {
  String id;

  DeleteProductEvent(this.id);
}

class CreateProductEvent extends ProductEvent {
  ProductEntity productEntity;

  CreateProductEvent(this.productEntity);
}