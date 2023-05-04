// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());


class Wishlist {
  Wishlist({
    required this.id,
    required this.user,
    required this.products,
    required this.v,
  });

  String id;
  List<String> user;
  List<Productw> products;
  int v;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["_id"],
        user: List<String>.from(json["user"].map((x) => x)),
        products: List<Productw>.from(
            json["products"].map((x) => Productw.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": List<dynamic>.from(user.map((x) => x)),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class Productw {
  Productw({
    required this.id,
    required this.productname,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String productname;
  String image;
  String description;
  int price;
  int quantity;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Productw.fromJson(Map<String, dynamic> json) => Productw(
        id: json["_id"],
        productname: json["productname"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productname": productname,
        "image": image,
        "description": description,
        "price": price,
        "quantity": quantity,
        "category": category,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
