import 'package:flutter/foundation.dart';
import 'package:order_app/data/data.dart';

import 'package:order_app/domain/domain.dart';

class OrderEntity {
  final String id;
  final DateTime date;
  final double amount;
  final List<ProductDisplay> products;

  factory OrderEntity.fromModel(OrderModel model) {
    final productList = model.products;
    //remove duplicates
    final productSet = productList.toSet();
    //convert to list of product display
    final productDisplayList = productSet
        .map(
          (e) => ProductDisplay.noId(
            product: ProductEntity.fromModel(e),
            quantity: productList.where((element) => element.id == e.id).length,
          ),
        )
        .toList();
    return OrderEntity(
      id: model.id,
      date: model.date,
      amount: model.amount,
      products: productDisplayList,
    );
  }

  OrderEntity({
    required this.id,
    required this.date,
    required this.amount,
    required this.products,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderEntity &&
        other.id == id &&
        other.date == date &&
        other.amount == amount &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ amount.hashCode ^ products.hashCode;
  }
}
