
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_sources.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usescase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product_usescase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';


@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    InternetConnectionChecker,
    NetworkInfo,
    GetProductUsecase,
    GetAllProductUsecase,
    UpdateProductUsecase ,
    DeleteProductUsecase,
    CreateProductUsecase,

    SharedPreferences,
    
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
  )

void main(){

    
}

class ProdcutLocalDataSource {
}

