import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:order_app/domain/domain.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._useCase) : super(const ProductState()) {
    on<WatchProducts>(
      (event, emit) {
        _subscription?.cancel();
        emit(state.copyWith(status: ProductStatus.loading));
        _subscription = _useCase(NoParams()).listen((products) {
          add(_ReceiveProducts(products));
        });
      },
      transformer: sequential(),
    );
    on<_ReceiveProducts>(
      (event, emit) {
        final res = event.products;
        emit(res.fold(
          (l) => state.copyWith(
            status: ProductStatus.error,
            error: l,
          ),
          (r) => state.copyWith(
            status: ProductStatus.success,
            products: r,
          ),
        ));
      },
      transformer: sequential(),
    );
  }

  final WatchProductsUseCase _useCase;
  StreamSubscription<Either<String, List<ProductEntity>>>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
