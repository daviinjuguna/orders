// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OnlineCart _$$_OnlineCartFromJson(Map<String, dynamic> json) =>
    _$_OnlineCart(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      id: json['id'] as String,
      productId: json['product_id'] as String,
    );

Map<String, dynamic> _$$_OnlineCartToJson(_$_OnlineCart instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'product': instance.product.toJson(),
      'id': instance.id,
      'product_id': instance.productId,
    };
