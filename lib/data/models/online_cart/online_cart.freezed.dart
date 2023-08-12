// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OnlineCart _$OnlineCartFromJson(Map<String, dynamic> json) {
  return _OnlineCart.fromJson(json);
}

/// @nodoc
mixin _$OnlineCart {
  UserModel get user => throw _privateConstructorUsedError;
  ProductModel get product => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlineCartCopyWith<OnlineCart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlineCartCopyWith<$Res> {
  factory $OnlineCartCopyWith(
          OnlineCart value, $Res Function(OnlineCart) then) =
      _$OnlineCartCopyWithImpl<$Res, OnlineCart>;
  @useResult
  $Res call(
      {UserModel user, ProductModel product, String id, String productId});

  $UserModelCopyWith<$Res> get user;
  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class _$OnlineCartCopyWithImpl<$Res, $Val extends OnlineCart>
    implements $OnlineCartCopyWith<$Res> {
  _$OnlineCartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? product = null,
    Object? id = null,
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res> get product {
    return $ProductModelCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OnlineCartCopyWith<$Res>
    implements $OnlineCartCopyWith<$Res> {
  factory _$$_OnlineCartCopyWith(
          _$_OnlineCart value, $Res Function(_$_OnlineCart) then) =
      __$$_OnlineCartCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel user, ProductModel product, String id, String productId});

  @override
  $UserModelCopyWith<$Res> get user;
  @override
  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class __$$_OnlineCartCopyWithImpl<$Res>
    extends _$OnlineCartCopyWithImpl<$Res, _$_OnlineCart>
    implements _$$_OnlineCartCopyWith<$Res> {
  __$$_OnlineCartCopyWithImpl(
      _$_OnlineCart _value, $Res Function(_$_OnlineCart) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? product = null,
    Object? id = null,
    Object? productId = null,
  }) {
    return _then(_$_OnlineCart(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class _$_OnlineCart extends _OnlineCart {
  const _$_OnlineCart(
      {required this.user,
      required this.product,
      required this.id,
      required this.productId})
      : super._();

  factory _$_OnlineCart.fromJson(Map<String, dynamic> json) =>
      _$$_OnlineCartFromJson(json);

  @override
  final UserModel user;
  @override
  final ProductModel product;
  @override
  final String id;
  @override
  final String productId;

  @override
  String toString() {
    return 'OnlineCart(user: $user, product: $product, id: $id, productId: $productId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnlineCart &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, product, id, productId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnlineCartCopyWith<_$_OnlineCart> get copyWith =>
      __$$_OnlineCartCopyWithImpl<_$_OnlineCart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OnlineCartToJson(
      this,
    );
  }
}

abstract class _OnlineCart extends OnlineCart {
  const factory _OnlineCart(
      {required final UserModel user,
      required final ProductModel product,
      required final String id,
      required final String productId}) = _$_OnlineCart;
  const _OnlineCart._() : super._();

  factory _OnlineCart.fromJson(Map<String, dynamic> json) =
      _$_OnlineCart.fromJson;

  @override
  UserModel get user;
  @override
  ProductModel get product;
  @override
  String get id;
  @override
  String get productId;
  @override
  @JsonKey(ignore: true)
  _$$_OnlineCartCopyWith<_$_OnlineCart> get copyWith =>
      throw _privateConstructorUsedError;
}
