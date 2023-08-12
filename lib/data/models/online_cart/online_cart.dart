import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:order_app/data/data.dart';
import 'package:uuid/uuid.dart';

part 'online_cart.freezed.dart';
part 'online_cart.g.dart';

@freezed
class OnlineCart with _$OnlineCart {
  const OnlineCart._();
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory OnlineCart({
    required UserModel user,
    required ProductModel product,
    required String id,
    required String productId,
  }) = _OnlineCart;

  factory OnlineCart.create({
    required UserModel user,
    required ProductModel products,
  }) =>
      OnlineCart(
        user: user,
        product: products,
        productId: products.id,
        id: const Uuid().v4(),
      );

  factory OnlineCart.fromJson(Map<String, dynamic> json) =>
      _$OnlineCartFromJson(json);

  ///Product from firestore
  factory OnlineCart.fromFirestore(DocumentSnapshot doc) =>
      OnlineCart.fromJson(doc.data() as Map<String, dynamic>);
}
