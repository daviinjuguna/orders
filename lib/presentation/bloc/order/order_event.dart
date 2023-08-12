part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class WatchOrders extends OrderEvent {}

class _ReceivedOrders extends OrderEvent {
  final Either<String, List<OrderEntity>> failureOrOrders;

  _ReceivedOrders(this.failureOrOrders);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedOrders && other.failureOrOrders == failureOrOrders;
  }

  @override
  int get hashCode => failureOrOrders.hashCode;
}
