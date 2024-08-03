import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase{
  final ProductRepository productRepository;
  UpdateProductUsecase(this.productRepository);

  Future<Either<Failure,void>> execute(ProductEntity product) async{
    return await productRepository.updateProduct(product);
    
  }
}