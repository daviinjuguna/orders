part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class WatchProducts extends ProductEvent {}

class _ReceiveProducts extends ProductEvent {
  final Either<String, List<ProductEntity>> products;

  _ReceiveProducts(this.products);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceiveProducts && other.products == products;
  }

  @override
  int get hashCode => products.hashCode;
}
