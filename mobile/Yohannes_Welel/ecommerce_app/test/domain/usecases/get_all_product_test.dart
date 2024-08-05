
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){

  late GetAllProductUsecase getAllProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository = MockProductRepository();
    getAllProductUsecase=GetAllProductUsecase(mockProductRepository);
    });  



  // ignore: constant_identifier_names
  const List<ProductEntity>AllProductDetail=[ ProductEntity(id:'1',name: 'Shoes',description: 'brand new Shoes',price: 23.0,imageUrl: 'imagepath'),
     ProductEntity(id:'2',name: 'Shoes',description: 'description',price: 23.0,imageUrl: 'imagepath')
  ];



    test(
          'this is All product repository tested Successfully',

          () async {
            //arrange
            when(
              mockProductRepository.getAll()
            ).thenAnswer((_) async =>const Right(AllProductDetail) );


            //act
            final result = await getAllProductUsecase.execute();


            //assert
          expect(result,const Right(AllProductDetail));


          },
          );

  
}