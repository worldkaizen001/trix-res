// To parse this JSON data, do
//
//     final useLoginModel = useLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel useLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String useLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    final String email;
    final String password;
    final String? deviceId;

    UserLoginModel({
        required this.email,
        required this.password,
        this.deviceId,
    });

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        email: json["email"],
        password: json["password"],
        deviceId: json["device_id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "device_id": deviceId,
    };
}
