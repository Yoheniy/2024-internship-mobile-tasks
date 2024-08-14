import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/delete_product_usescase.dart';
import '../../domain/usecases/get_all_product_usecase.dart';
import '../../domain/usecases/get_product_usescase.dart';
import '../../domain/usecases/insert_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase getProductUsecase;
  final GetAllProductUsecase getAllProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final CreateProductUsecase createProductUsecase;

  ProductBloc(
      
       this.getProductUsecase,
       this.getAllProductUsecase,
      this.updateProductUsecase,
       this.deleteProductUsecase,
       this.createProductUsecase,
      
       )
      : super(InitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getProductUsecase.execute(event.id);
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        emit(LoadedSingleProductState(data));
      });
    });

    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getAllProductUsecase.execute();
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        List<ProductModel> newProduct = [];

        data.forEach((el) async => newProduct.add(ProductModel.fromEntity(el)));

        emit(LoadedAllProductState(allProducts: newProduct));
      });
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await updateProductUsecase.execute(event.productEntity);

      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        return data;
      });
    });

    on<DeleteProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await deleteProductUsecase.execute(event.id);

        result.fold((failure) {
          emit(ErrorState(failure.message));
        }, (data) {
          return data;
        });
      },
    );

    on<CreateProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await createProductUsecase.execute(event.productEntity);

        result.fold((failure) {
          emit(ErrorState(failure.message));
        }, (data) {
          return data;
        });
      },
    );
  }
}