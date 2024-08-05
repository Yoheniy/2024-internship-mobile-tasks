
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usescase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){

  late  DeleteProductUsescase deleteProductUsescase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    deleteProductUsescase=DeleteProductUsescase(mockProductRepository);
    });  






       //testing Single product by id
        String id='1';
        test(
          'Deleting single  product detail tested  successfully',

          () async {
            //arrange
            when(
              mockProductRepository.deleteProduct(id )
            // ignore: void_checks
            ).thenAnswer((_) async =>const Right(true) );


            //act
            final result = await deleteProductUsescase.execute(id);


            //assert
          expect(result,const Right(true));


          },
          );




}

