import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:order_app/domain/domain.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._useCase) : super(const OrderState()) {
    on<WatchOrders>((event, emit) {
      _subscription?.cancel();
      emit(state.copyWith(status: OrderStatus.loading));
      _subscription = _useCase(NoParams()).listen((order) {
        add(_ReceivedOrders(order));
      });
    });
    on<_ReceivedOrders>((event, emit) {
      final res = event.failureOrOrders;
      emit(res.fold(
        (l) => state.copyWith(status: OrderStatus.failure, error: l),
        (r) => state.copyWith(
          status: OrderStatus.success,
          orders: r,
          error: '',
        ),
      ));
    });
  }

  final WatchOrderUseCase _useCase;

  StreamSubscription<Either<String, List<OrderEntity>>>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
