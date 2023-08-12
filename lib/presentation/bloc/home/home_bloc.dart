import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:order_app/domain/domain.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._useCase) : super(const HomeState()) {
    on<WatchHomeDisplay>(
      (event, emit) {
        _subscription?.cancel();
        emit(state.copyWith(status: HomeStatus.loading));
        _subscription = _useCase(NoParams())
            .listen((display) => add(_ReceivedHomeDisplay(display)));
      },
      transformer: sequential(),
    );
    on<_ReceivedHomeDisplay>(
      (event, emit) {
        final res = event.display;
        emit(res.fold(
          (l) => state.copyWith(status: HomeStatus.failure, error: l),
          (r) => state.copyWith(status: HomeStatus.success, display: r),
        ));
      },
      transformer: sequential(),
    );
  }

  final HomeDisplayUseCase _useCase;

  StreamSubscription<Either<String, HomeDisplay>>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
