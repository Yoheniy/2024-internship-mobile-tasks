import '../../domain/entities/product_entity.dart';

class GetProductModel extends ProductEntity {

  const GetProductModel ({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
  });


  factory GetProductModel.fromJson(Map<String,dynamic> json) => GetProductModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    price: json['price']
  );
  Map<String,dynamic> toJson() => {
    'id' : 1,
    'name' : 'Nike',
    'description' : 'new brand shoes',
    'imageUrl' : 'imagepath',
    'price' : 300.0
  };
}