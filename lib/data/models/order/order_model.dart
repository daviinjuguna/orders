import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:order_app/data/data.dart';
import 'package:uuid/uuid.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._();
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory OrderModel({
    required String id,
    required UserModel user,
    required List<ProductModel> products,
    required DateTime date,
    required double amount,
  }) = _OrderModel;

  ///Product from firestore
  factory OrderModel.fromFirestore(DocumentSnapshot doc) =>
      OrderModel.fromJson(doc.data() as Map<String, dynamic>);

  factory OrderModel.create({
    required UserModel user,
    required List<ProductModel> products,
    required double amount,
  }) =>
      OrderModel(
        id: const Uuid().v4(),
        user: user,
        products: products,
        date: DateTime.now(),
        amount: amount,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
