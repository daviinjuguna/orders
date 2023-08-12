// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';

import 'package:order_app/domain/domain.dart';

class HomeDisplay {
  final CartEntity cart;
  final List<ProductEntity> products;

  List<_ProdInCart> get productsInCart {
    final addedProd = cart.products.map((e) => e.product);
    final list = products
        .map((product) => _ProdInCart(
              product,
              addedProd.where((element) => element.id == product.id).length,
              cart,
            ))
        .toList();
    return list;
  }

  HomeDisplay({
    required this.cart,
    required this.products,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeDisplay &&
        other.cart == cart &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode => cart.hashCode ^ products.hashCode;
}

class _ProdInCart {
  final ProductEntity product;
  final int no;
  final CartEntity _cart;

  List<String> get cartIds {
    final products = _cart.products;
    final filteredProd = products.where((e) => e.product.id == product.id);
    final ids = filteredProd.map((e) => e.cartId).toList();
    return ids;
  }

  _ProdInCart(this.product, this.no, this._cart);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ProdInCart &&
        other.product == product &&
        other.no == no &&
        other._cart == _cart;
  }

  @override
  int get hashCode => product.hashCode ^ no.hashCode ^ _cart.hashCode;
}
