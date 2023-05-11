// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());


class Wishlist {
  Wishlist({
     this.id,
     this.user,
     this.products,
     this.v,
  });

  String? id;
  List<String>? user;
  List<Productw>? products;
  int? v;


  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["_id"],
        user: List<String>.from(json["user"].map((x) => x)),
        products: List<Productw>.from(
            json["products"].map((x) => Productw.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": List<dynamic>.from(user!.map((x) => x)),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "__v": v,
      };
}

class Productw {
  Productw({
     this.id,
     this.productname,
     this.image,
     this.description,
     this.price,
     this.quantity,
     this.category,
     this.createdAt,
     this.updatedAt,
     this.v,
  });

  String? id;
  String? productname;
  String? image;
  String? description;
  int? price;
  int? quantity;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

Map<String, dynamic> toJson() => {
        "_id": id,
        "productname": productname,
        "image": image,
        "description": description,
        "price": price,
        "quantity": quantity,
        "category": category,
        "createdAt": createdAt!,
        "updatedAt": updatedAt!,
        "__v": v,
      };
  factory Productw.fromJson(Map<String, dynamic> jsonData) {
    print("wissal chebbi product:");
    print(jsonData);
    print(jsonData['image']);
    return Productw(
        id: jsonData['_id'],
        productname: jsonData['productname'],
        image: jsonData['image'],
        description: jsonData['description'],
        category: jsonData['category'],
        price: jsonData['price'],
        quantity: jsonData['quantity']);
  }
}
