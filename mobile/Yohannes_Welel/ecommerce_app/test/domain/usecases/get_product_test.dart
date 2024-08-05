
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product_usescase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){

  late GetProductUsescases getProductUsescases;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    getProductUsescases=GetProductUsescases(mockProductRepository);
    });  

  // ignore: constant_identifier_names
  const SingleProductDetail = ProductEntity(id:'1',name: 'name',description: 'description',price: 23.0,imageUrl: 'imagepath');





       //testing Single product by id
        String id='1';
        test(
          'this is single  product detail tested  successfully',

          () async {
            //arrange
            when(
              mockProductRepository.getProductById(id)
            ).thenAnswer((_) async =>const Right(SingleProductDetail) );


            //act
            final result = await getProductUsescases.execute(id);


            //assert
          expect(result,const Right(SingleProductDetail));


          },
          );




}

