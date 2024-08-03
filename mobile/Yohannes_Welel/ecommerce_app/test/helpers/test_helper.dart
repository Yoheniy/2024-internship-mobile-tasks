
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';

import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    ProductRepository,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
  )

void main(){

    
}

