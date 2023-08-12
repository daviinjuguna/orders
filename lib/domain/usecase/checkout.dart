import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:order_app/domain/domain.dart';

class CheckoutUseCase extends UseCase<Unit, CheckoutParams> {
  CheckoutUseCase(this._repo);

  @override
  Future<Either<String, Unit>> call(CheckoutParams params) {
    return _repo.checkout(
      products: params.products,
      amount: params.amount,
    );
  }

  final ProductRepo _repo;
}

class CheckoutParams {
  final double amount;
  final List<ProductEntity> products;
  CheckoutParams({
    required this.amount,
    required this.products,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckoutParams &&
        other.amount == amount &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode => amount.hashCode ^ products.hashCode;
}
