import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:order_app/domain/domain.dart';

part 'splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, UserEntity> {
  SplashBloc(this._useCase) : super(UserEntity.initial()) {
    on<SplashStart>((event, emit) {
      _subscription?.cancel();
      _subscription = _useCase.call().listen((user) {
        add(_ReceivedAuth(user));
      });
    });
    on<_ReceivedAuth>((event, emit) => emit(event.user));
  }

  final WatchAuthUseCase _useCase;

  StreamSubscription<UserEntity>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
