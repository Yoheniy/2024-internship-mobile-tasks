import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductUsescases{
  final ProductRepository productRepository;
  GetProductUsescases(this.productRepository);


  Future<Either<Failure, ProductEntity>> execute(String id) async {
    return await productRepository.getProductById(id);
  }

}