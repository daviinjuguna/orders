part of 'order_bloc.dart';

@immutable
class OrderState {
  final OrderStatus status;
  final List<OrderEntity> orders;
  final String error;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const <OrderEntity>[],
    this.error = '',
  });

  OrderState copyWith({
    OrderStatus? status,
    List<OrderEntity>? orders,
    String? error,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderState &&
        other.status == status &&
        listEquals(other.orders, orders) &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ orders.hashCode ^ error.hashCode;
}

enum OrderStatus { initial, loading, success, failure }
