import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';
import '../entities/product_entity.dart';



abstract class ProductRepository{
  Future<Either<Failure,ProductEntity>> getProductById(String id);
  Future<Either<Failure,List<ProductEntity>>> getAll();
  Future<Either<Failure,bool>> insertProduct(ProductEntity product);
  Future<Either<Failure,bool>> deleteProduct(String id);
  Future<Either<Failure,bool>> updateProduct(ProductEntity product);



  
}
