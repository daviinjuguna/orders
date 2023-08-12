part of 'cart_cubit.dart';

enum CartStatus { initial, loading, success, failure }

@immutable
class CartState {
  final CartStatus status;
  final String error;
  const CartState({
    this.status = CartStatus.initial,
    this.error = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartState && other.status == status && other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode;

  CartState copyWith({
    CartStatus? status,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
