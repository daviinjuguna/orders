import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:order_app/domain/domain.dart';

abstract class ProductRepo {
  Stream<Either<String, List<ProductEntity>>> getProducts();

  @protected
  Future<void> seedProducts();

  //add to cart
  Future<Either<String, Unit>> addToCart(ProductEntity product);
  //remove from cart
  Future<Either<String, Unit>> removeFromCart(String catId);

  //clear cart
  Future<Either<String, Unit>> clearCart(ProductEntity? product);

  //watch cart
  Stream<Either<String, CartEntity>> watchCart();

  //watch cart and products
  Stream<Either<String, HomeDisplay>> watchHomeDisplay();

  //checkout
  Future<Either<String, Unit>> checkout({
    required List<ProductEntity> products,
    required double amount,
  });

  //watch orders
  Stream<Either<String, List<OrderEntity>>> watchOrders();
}
