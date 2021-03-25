// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);
import 'dart:convert';

class Login {
  Login({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
