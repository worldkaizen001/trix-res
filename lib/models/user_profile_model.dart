// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

// UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

// String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    final int? id;
    final String? photo;
    final String firstname;
    final String lastname;
    final String email;
    final String? telephone;
    final String? address;
    final String? deviceId;
    final bool? active;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic wallet;

    UserProfileModel({
        required this.id,
        this.photo,
        required this.firstname,
        required this.lastname,
        required this.email,
        this.telephone,
        this.address,
        this.deviceId,
         this.active,
         this.createdAt,
         this.updatedAt,
        this.wallet,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"] ,
        photo: json["photo"],
        firstname: json["firstname"] ,
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        address: json["address"],
        deviceId: json["device_id"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        wallet: json["wallet"],

    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "firstname": firstname,
    //     "lastname": lastname,
    //     "email": email,
    //     "telephone": telephone,
    //     "address": address,
    //     "role": role,
    //     "device_id": deviceId,
    //     "active": active,
    //     "created_at": createdAt?.toIso8601String(),
    //     "updated_at": updatedAt?.toIso8601String(),
    // };

    String get fullname => "$firstname $lastname";

    int get points => wallet['balance'];

}
