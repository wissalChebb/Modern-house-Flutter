import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  String id;
  final Product product;
  final int numOfItem;

  Cart({required this.id, required this.product, required this.numOfItem});
}
