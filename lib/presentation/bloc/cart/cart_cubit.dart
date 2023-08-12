import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:order_app/domain/domain.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._clearCartUseCase,
  ) : super(const CartState());

  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  Future<void> addToCart(ProductEntity prod) async {
    emit(state.copyWith(status: CartStatus.loading));
    final res = await _addToCartUseCase(prod);
    emit(res.fold(
      (l) => state.copyWith(status: CartStatus.failure, error: l),
      (r) => state.copyWith(status: CartStatus.success, error: ''),
    ));
  }

  Future<void> removeFromCart(String cartId) async {
    emit(state.copyWith(status: CartStatus.loading));
    final res = await _removeFromCartUseCase(cartId);
    emit(res.fold(
      (l) => state.copyWith(status: CartStatus.failure, error: l),
      (r) => state.copyWith(status: CartStatus.success, error: ''),
    ));
  }

  Future<void> clearCart(ProductEntity? product) async {
    emit(state.copyWith(status: CartStatus.loading));
    final res = await _clearCartUseCase(product);
    emit(res.fold(
      (l) => state.copyWith(status: CartStatus.failure, error: l),
      (r) => state.copyWith(status: CartStatus.success, error: ''),
    ));
  }
}
