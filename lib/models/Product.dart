import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String productname;
  final String image;
  final String description;
  final double price;
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

<<<<<<< Updated upstream
List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/download.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/download.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/download.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];
=======
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
>>>>>>> Stashed changes

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productname: json['productname'],
      image: json['image'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity']?.toDouble() ?? 0.0,
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
    );
  }
}
