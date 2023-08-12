// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:order_app/data/data.dart';

part 'cart_model.freezed.dart';

@freezed
class CartModel with _$CartModel {
  const CartModel._();
  const factory CartModel({
    required UserModel user,
    required List<OnlineCart> items,
  }) = _CartModel;
}
