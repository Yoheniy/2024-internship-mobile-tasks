import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {

  const ProductModel ({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
  });


  factory ProductModel.fromJson(Map<String,dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    price: (json['price'] as num).toDouble(),  //ensure price is a double
  );
  Map<String,dynamic> toJson() => {
    'id' : '1',
    'name' : 'Nike',
    'description' : 'new brand shoes',
    'imageUrl' : 'imagepath',
    'price' : 300.0
  };

 ProductEntity toEntity() {
  return ProductEntity(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    price: price,
  );
}

}