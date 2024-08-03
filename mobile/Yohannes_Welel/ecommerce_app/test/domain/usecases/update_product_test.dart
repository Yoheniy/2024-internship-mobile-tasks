
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){

  late UpdateProductUsecase updateProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    updateProductUsecase=UpdateProductUsecase(mockProductRepository);
    });  

  const tProduct = ProductEntity(id:1,name: 'name',description: 'description',price: 23.0,imageUrl: 'imagepath');





       //testing Single product by id
 
        test(
          'product update detail tested  successfully',

          () async {
            //arrange
            when(
              mockProductRepository.updateProduct(tProduct)
            ).thenAnswer((_) async =>const Right(tProduct) );


            //act
            final result = await updateProductUsecase.execute(tProduct);


            //assert
          expect(result,const Right(tProduct));


          },
          );




}

