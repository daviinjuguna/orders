import 'package:order_app/data/data.dart';

class ProductEntity {
  final String id;
  final String name;
  final String? image;
  final double price;

  ProductEntity({
    required this.id,
    required this.name,
    this.image,
    required this.price,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      image: model.image,
      price: model.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEntity &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ price.hashCode;
  }
}

extension ProductEntityX on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      image: image,
      price: price,
    );
  }
}
