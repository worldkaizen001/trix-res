// To parse this JSON data, do
//
//     final userRegisterationModel = userRegisterationModelFromJson(jsonString);

import 'dart:convert';

UserRegisterationModel userRegisterationModelFromJson(String str) => UserRegisterationModel.fromJson(json.decode(str));

String userRegisterationModelToJson(UserRegisterationModel data) => json.encode(data.toJson());

class UserRegisterationModel {
    String firstname;
    String lastname;
    String email;
    String telephone;
    String password;
    String confirmPassword;

    UserRegisterationModel({
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.telephone,
        required this.password,
        required this.confirmPassword,
    });

    factory UserRegisterationModel.fromJson(Map<String, dynamic> json) => UserRegisterationModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "password": password,
        "confirmPassword": confirmPassword,
    };
}
