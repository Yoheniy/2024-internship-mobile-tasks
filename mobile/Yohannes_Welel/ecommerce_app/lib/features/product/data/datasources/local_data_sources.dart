import '../models/product_model.dart';

abstract class ProductLocalDataSource{
  Future<ProductModel?> getCurrentProduct(int id);
  Future<List<ProductModel>> getAll();
  Future<void>insertProduct(ProductModel product);
  Future<void>deleteProduct(int id);
  Future<void>updateProduct(ProductModel product);

   
}