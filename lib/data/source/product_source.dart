import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_app/data/data.dart';
import 'package:order_app/data/models/online_cart/online_cart.dart';

abstract class ProductSource {
  Stream<List<ProductModel>> getProducts();
  Future<ProductModel> createProduct(ProductModel product);

  //add
  Future<void> addToCart(ProductModel product);

  // remove from cart
  Future<void> removeFromCart(String catId);

  //clear cart
  Future<void> clearCart(ProductModel? product);

  //watch cart
  Stream<CartModel> watchCart();

  //checkout
  Future<void> checkout({
    required List<ProductModel> products,
    required double amount,
  });

  //watch orders
  Stream<List<OrderModel>> watchOrders();
}

class ProductSourceImpl implements ProductSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProductSourceImpl(this._firestore, this._auth);

  @override
  Stream<List<ProductModel>> getProducts() async* {
    final stream = _firestore.collection(Collections.products).snapshots();
    yield* stream.map((event) {
      return event.docs.map((e) => ProductModel.fromFirestore(e)).toList();
    });
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      await _firestore
          .collection(Collections.products)
          .doc(product.id)
          .set(product.toJson());
      return product;
    } catch (e, s) {
      log('createProduct', error: e, stackTrace: s);
      rethrow;
    }
  }

  //just add a product to db to collection of user
  @override
  Future<void> addToCart(ProductModel product) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final onlineCart = OnlineCart.create(
        user: UserModel(uid: user.uid, email: user.email),
        products: product,
      );

      await _firestore
          .collection(Collections.carts)
          .doc(user.uid)
          .collection(Collections.products)
          .doc(onlineCart.id)
          .set(
            onlineCart.toJson(),
          );
    } catch (e, s) {
      log("addToCart", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(String catId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      await _firestore
          .collection(Collections.carts)
          .doc(user.uid)
          .collection(Collections.products)
          .doc(catId)
          .delete();
    } catch (e, s) {
      log("removeFromCart", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> clearCart(ProductModel? product) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      Future<QuerySnapshot<Map<String, dynamic>>> query;

      if (product != null) {
        query = _firestore
            .collection(Collections.carts)
            .doc(user.uid)
            .collection(Collections.products)
            .where('product_id', isEqualTo: product.id)
            .get();
      } else {
        query = _firestore
            .collection(Collections.carts)
            .doc(user.uid)
            .collection(Collections.products)
            .get();
      }

      final snapshot = await query;
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e, s) {
      log('clear cart', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Stream<CartModel> watchCart() async* {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final stream = _firestore
        .collection(Collections.carts)
        .doc(user.uid)
        .collection(Collections.products)
        .snapshots();

    yield* stream.map((snapshots) {
      final carts =
          snapshots.docs.map((e) => OnlineCart.fromFirestore(e)).toList();

      return CartModel(
        user: UserModel(uid: user.uid, email: user.email),
        items: carts,
      );
    });
  }

  @override
  Future<void> checkout({
    required List<ProductModel> products,
    required double amount,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final order = OrderModel.create(
        user: UserModel(uid: user.uid, email: user.email),
        products: products,
        amount: amount,
      );

      await _firestore
          .collection(Collections.orders)
          .doc(user.uid)
          .collection(Collections.orders)
          .doc(order.id)
          .set(order.toJson());
    } catch (e, s) {
      log('Checkout', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Stream<List<OrderModel>> watchOrders() async* {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final stream = _firestore
        .collection(Collections.orders)
        .doc(user.uid)
        .collection(Collections.orders)
        .snapshots();

    yield* stream.map((snapshots) {
      return snapshots.docs.map((e) => OrderModel.fromFirestore(e)).toList();
    });
  }
}
