import 'package:flutter/material.dart';
import 'package:pim/models/Product.dart';

class Cart {
  String? id;
  Product? product;
  List<Product>? products;
  int? numOfItem;
  String? idUser;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  bool? paid;
  String? date;
  String? etat;
  Cart(
      {
         this.id,
        this.idUser,
         this.product,
         this.products,
         this.numOfItem,
        this.createdAt,
        this.updatedAt,
      this.date,
      this.etat,
      this.paid,
        this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id :json['_id'],
        idUser : json['user'][0],
        product : json['products'] != null && json['products'][0] != null ? Product.fromJson(json['products'][0]) : null,
        products : json['products']?.map<Product>((e) => Product.fromJson(e)).toList(),
        quantity : json['quantity'],
        paid : json['paid'],
    date : json['date'],
    etat : json['etat'],
        createdAt : json['createdAt'],
    updatedAt : json['updatedAt']);
  }

}

