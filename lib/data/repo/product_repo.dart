import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:order_app/data/data.dart';
import 'package:order_app/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductSource _source;

  ProductRepoImpl(this._source);

  @override
  Stream<Either<String, List<ProductEntity>>> getProducts() async* {
    yield* _source.getProducts().map((products) {
      final list = products.map((e) => ProductEntity.fromModel(e)).toList();
      return right<String, List<ProductEntity>>(list);
    }).onErrorReturnWith((error, stackTrace) {
      log("getProducts", error: error, stackTrace: stackTrace);
      return left<String, List<ProductEntity>>(error.toString());
    });
  }

  @override
  Future<void> seedProducts() async {
    try {
      final products = ProductSeed().seed;
      for (final product in products) {
        await _source.createProduct(product);
      }
    } catch (e, s) {
      log('seedProducts', error: e, stackTrace: s);
      return;
    }
  }

  @override
  Future<Either<String, Unit>> addToCart(ProductEntity product) async {
    try {
      await _source.addToCart(product.toModel());
      return right(unit);
    } catch (e) {
      return left('Failed to add to cart');
    }
  }

  @override
  Future<Either<String, Unit>> removeFromCart(String catId) async {
    try {
      await _source.removeFromCart(catId);
      return right(unit);
    } catch (e) {
      return left('failed to remove to cart');
    }
  }

  @override
  Future<Either<String, Unit>> clearCart(ProductEntity? product) async {
    try {
      await _source.clearCart(product?.toModel());
      return right(unit);
    } catch (e) {
      return left('failed to remove to cart');
    }
  }

  @override
  Stream<Either<String, CartEntity>> watchCart() async* {
    yield* _source.watchCart().map((model) {
      return right<String, CartEntity>(CartEntity.fromModel(model));
    }).onErrorReturnWith((error, stackTrace) {
      log("watchCart", error: error, stackTrace: stackTrace);
      return left<String, CartEntity>(error.toString());
    });
  }

  @override
  Stream<Either<String, HomeDisplay>> watchHomeDisplay() async* {
    final productStream = _source.getProducts();
    final cartStream = _source.watchCart();
    final orderStream = _source.watchOrders();
    final stream = Rx.combineLatest3(productStream, cartStream, orderStream,
        (productList, cartModel, orders) {
      final products =
          productList.map((e) => ProductEntity.fromModel(e)).toList();
      // final orders = ordersModel.map((e) => OrderEntity.fromModel(e)).toList();

      //sort products based on orders

      products.sort((a, b) {
        //sort by date
        final orderADate = orders
            .firstWhereOrNull((element) =>
                element.products.any((element) => element.id == a.id))
            ?.date;
        final orderBDate = orders
            .firstWhereOrNull((element) =>
                element.products.any((element) => element.id == b.id))
            ?.date;

        if (orderADate != null && orderBDate != null) {
          return orderBDate.compareTo(orderADate);
        }
        //sort by quantity
        final productsA = orders
            .map((e) => e.products)
            .expand((e) => e)
            .where((prod) => prod.id == a.id)
            .length;
        final productsB = orders
            .map((e) => e.products)
            .expand((e) => e)
            .where((prod) => prod.id == b.id)
            .length;
        return productsB.compareTo(productsA);
      });

      final cart = CartEntity.fromModel(cartModel);
      return HomeDisplay(cart: cart, products: products);
    });
    yield* stream.map((event) {
      return right<String, HomeDisplay>(event);
    }).onErrorReturnWith((error, stackTrace) {
      log("watchHomeDisplay", error: error, stackTrace: stackTrace);
      return left<String, HomeDisplay>(error.toString());
    });
  }

  @override
  Future<Either<String, Unit>> checkout({
    required List<ProductEntity> products,
    required double amount,
  }) async {
    try {
      await _source.checkout(
        products: products.map((e) => e.toModel()).toList(),
        amount: amount,
      );
      //clear cart
      await _source.clearCart(null);
      return right(unit);
    } catch (e) {
      return left('failed to checkout');
    }
  }

  @override
  Stream<Either<String, List<OrderEntity>>> watchOrders() async* {
    yield* _source.watchOrders().map((orders) {
      final list = orders.map((e) => OrderEntity.fromModel(e)).toList();
      return right<String, List<OrderEntity>>(list);
    }).onErrorReturnWith((error, stackTrace) {
      log("watchOrders", error: error, stackTrace: stackTrace);
      return left<String, List<OrderEntity>>(error.toString());
    });
  }
}
