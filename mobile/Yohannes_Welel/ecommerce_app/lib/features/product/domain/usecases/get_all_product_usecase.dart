import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetAllProductUsecase{
  ProductRepository productRepository;
  GetAllProductUsecase(this.productRepository);
  Future<Either<Failure,List<ProductEntity>>> execute() async{
    return await productRepository.getAllProducts();
    
  } 
}