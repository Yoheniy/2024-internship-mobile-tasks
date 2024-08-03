import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this .price,
    required this.imageUrl
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl; 

  @override

  List<Object?> get props =>
    [
      id,
      name,
      description,
      price,
      imageUrl

    ];

  

  


  
}