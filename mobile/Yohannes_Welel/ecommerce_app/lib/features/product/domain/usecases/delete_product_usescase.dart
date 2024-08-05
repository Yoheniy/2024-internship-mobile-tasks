import 'package:dartz/dartz.dart';

import '../../../../core/errormessage/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsescase{
  final ProductRepository productRepository;
  DeleteProductUsescase(this.productRepository);
  Future<Either<Failure,bool>> execute(String id) async{
    return await productRepository.deleteProduct(id);

  }
}