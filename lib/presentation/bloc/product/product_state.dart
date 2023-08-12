part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<ProductEntity> products;
  final ProductStatus status;
  final String error;
  const ProductState({
    this.products = const [],
    this.status = ProductStatus.initial,
    this.error = '',
  });

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductState &&
        listEquals(other.products, products) &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode => products.hashCode ^ status.hashCode ^ error.hashCode;
}

enum ProductStatus { initial, loading, success, error }
