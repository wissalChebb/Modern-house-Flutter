import 'package:flutter/material.dart';

import 'Product.dart';


import 'User.dart';

class Cart {
  Cart({
    required this.id,
    this.idUser,
    required this.product,
    required this.numOfItem,
    this.createdAt,
    this.updatedAt,
  });

  Cart.fromJson(dynamic json) {
    id = json['_id'];
    idUser = json['user'];
    product = json['products'] != null ? json['product'] : "";

    quantity = json['quantity'];
    paid = json['paid'];
    quantity = json['quantity'];
    date = json['date'];
    etat = json['etat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  Product? product;
  int? numOfItem;
  String? idUser;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  bool? paid;
  String? date;
  String? etat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = id;
    map['product'] = product;
    map['paid'] = paid;
    map['quantity'] = quantity;
    map['date'] = date;

    map['etat'] = etat;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

/*
class Cart {
  String id;
  Product product;
  final int numOfItem;

  Cart({required this.id, required this.product, required this.numOfItem});
}

// Demo data for our cart

// List<Cart> demoCarts = [
//   Cart(product: demoProducts[0], numOfItem: 2),
//   Cart(product: demoProducts[1], numOfItem: 1),
//   Cart(product: demoProducts[3], numOfItem: 1),
// ];*/