// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
User? user;

class User {
  User({
     this.username,
     this.email,
     this.password,
     this.role,
     this.verified,
     this.banned,
     this.image,
     this.id,
     this.createdAt,
     this.updatedAt,
     this.v,
  });

  String? username;
  String? email;
  String? password;
  String? role;
  bool? verified;
  bool? banned;
  String? image;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        image: json["Image"] ?? "",
        verified: json["verified"],
        banned: json["banned"] ?? false,
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "role": role,
        "Image": image,
        "verified": verified,
        "banned": banned,
        "_id": id,
        "createdAt": createdAt!,
        "updatedAt": updatedAt!,
        "__v": v,
      };
}
