import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String productname;
  final String image;
  final String description;
  final int price;
  final int quantity;
  final List<Color> colors;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.productname,
    required this.image,
    required this.colors,
    required this.description,
    required this.price,
    required this.quantity,
    this.isFavourite = false,
    this.isPopular = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productname': productname,
      'image': image,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productname: json['productname'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
    );
  }
}
