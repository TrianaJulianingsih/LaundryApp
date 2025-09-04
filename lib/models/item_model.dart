// To parse this JSON data, do
//
//     final layananModel = layananModelFromJson(jsonString);

import 'dart:convert';

ItemModel layananModelFromJson(String str) =>
    ItemModel.fromJson(json.decode(str));

String layananModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String? message;
  List<Data>? data;

  ItemModel({this.message, this.data});

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  String? name;
  int? price;
  int? categoryId;
  int? serviceTypeId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.name,
    this.price,
    this.categoryId,
    this.serviceTypeId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    price: json["price"],
    categoryId: json["category_id"],
    serviceTypeId: json["service_type_id"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "category_id": categoryId,
    "service_type_id": serviceTypeId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
