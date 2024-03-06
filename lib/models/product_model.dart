// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

// UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

// String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String? dpImage;
  final int amount;
  final int? loyaltyPts;
  final bool? available;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.dpImage,
    required this.amount,
    required this.loyaltyPts,
    this.available,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["namee"],
        dpImage: json["dpImage"],
        amount: json["amount"],
        loyaltyPts: json["loyaltyPts"],
        available: json["available"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
