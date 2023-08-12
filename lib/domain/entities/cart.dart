import 'package:flutter/foundation.dart';

import 'package:order_app/data/data.dart';
import 'package:order_app/domain/domain.dart';

class CartEntity {
  final UserEntity user;
  final List<ProductWithCartId> products;

  //get total price of cart
  double get total => products.fold(
        0,
        (previousValue, element) => previousValue + element.product.price,
      );

  int get prodCount => products.length;

  List<ProductDisplay> get display {
    final productList = products.map((e) => e.product);
    //remove duplicates
    final productSet = productList.toSet();
    //convert to list of product display
    final productDisplayList = productSet
        .map(
          (e) => ProductDisplay._(
            product: e,
            quantity: productList.where((element) => element.id == e.id).length,
            cartIds: products
                .where((element) => element.product.id == e.id)
                .map((e) => e.cartId)
                .toList(),
          ),
        )
        .toList();

    return productDisplayList;
  }

  CartEntity({
    required this.user,
    required this.products,
  });

  factory CartEntity.fromModel(CartModel model) {
    return CartEntity(
      products: model.items
          .map(
            (e) => ProductWithCartId(
              cartId: e.id,
              product: ProductEntity.fromModel(e.product),
            ),
          )
          .toList(),
      user: UserEntity.fromModel(model.user),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartEntity &&
        other.user == user &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode => user.hashCode ^ products.hashCode;
}

@protected
class ProductDisplay {
  final ProductEntity product;
  final int quantity;
  final List<String> cartIds;

  factory ProductDisplay.noId({
    required ProductEntity product,
    required int quantity,
  }) =>
      ProductDisplay._(
        product: product,
        quantity: quantity,
        cartIds: [],
      );

  ProductDisplay._({
    required this.product,
    required this.quantity,
    required this.cartIds,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDisplay &&
        other.product == product &&
        other.quantity == quantity &&
        listEquals(other.cartIds, cartIds);
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode ^ cartIds.hashCode;
}

class ProductWithCartId {
  final String cartId;
  final ProductEntity product;
  ProductWithCartId({
    required this.cartId,
    required this.product,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductWithCartId &&
        other.cartId == cartId &&
        other.product == product;
  }

  @override
  int get hashCode => cartId.hashCode ^ product.hashCode;
}
