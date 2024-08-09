import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  // Constructor for ProductModel which initializes properties from ProductEntity
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
  });

  // Factory constructor to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
        id: json['id'] as String? ?? '', // Provide default values for safety
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw FormatException('Error parsing ProductModel from JSON: $e');
    }
  }

  // Method to convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  // Convert ProductModel to ProductEntity
  @override
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
    );
  }

  // Factory constructor to create ProductModel from ProductEntity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
    );
  }

  // Convert a list of ProductModel to a list of ProductEntity
  static List<ProductEntity> allToEntity(List<ProductModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
