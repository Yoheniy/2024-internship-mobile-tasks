import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class CreateProductUsecase{
  final ProductRepository productRepository;
  CreateProductUsecase(this.productRepository);
  Future<Either<Failure, void>> execute(ProductEntity product) async{
    return await productRepository.insertProduct(product);


  }
}