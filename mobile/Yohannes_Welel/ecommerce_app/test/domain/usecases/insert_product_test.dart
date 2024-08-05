
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

import 'package:ecommerce_app/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){

  late CreateProductUsecase createProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    createProductUsecase=CreateProductUsecase(mockProductRepository);
    });  

  // ignore: constant_identifier_names
  const product = ProductEntity(id:'1',name: 'name',description: 'description',price: 23.0,imageUrl: 'imagepath');





       //testing Single product by id
 
        test(
          'this is single  product detail tested  successfully',

          () async {
            //arrange
            when(
              mockProductRepository.insertProduct(product)
            // ignore: void_checks
            ).thenAnswer((_) async =>const Right(true) );


            //act
            final result = await createProductUsecase.execute(product);


            //assert
          expect(result,const Right(true));


          },
          );




}

