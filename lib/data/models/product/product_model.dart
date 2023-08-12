import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    required String id,
    required String name,
    String? image,
    required double price,
  }) = _ProductModel;

  factory ProductModel.create({
    required String name,
    String? image,
    required double price,
  }) =>
      ProductModel(
        id: const Uuid().v4(),
        name: name,
        price: price,
        image: image,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  ///Product from firestore
  factory ProductModel.fromFirestore(DocumentSnapshot doc) =>
      ProductModel.fromJson(doc.data() as Map<String, dynamic>);
}

class ProductSeed {
  List<ProductModel> get seed => [
        ProductModel.create(
          name: "Nike Shoes",
          price: 2500,
          image:
              'https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2380&q=80',
        ),
        ProductModel.create(
          name: "PS 5",
          price: 90000,
          image:
              'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHM1fGVufDB8fDB8fHww&auto=format&fit=crop&w=700&q=60',
        ),
        ProductModel.create(
          name: "Macbook Air M1",
          price: 1000000,
          image:
              'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
        ),
        ProductModel.create(
          name: 'iPhone 14',
          price: 140000,
          image:
              'https://images.unsplash.com/photo-1663314326676-5e71b13ee62f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aXBob25lJTIwMTR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=700&q=60',
        )
      ];
}
