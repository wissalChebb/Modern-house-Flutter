import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pim/components/API_Consumer.dart';
import 'package:pim/components/default_button.dart';
import 'package:pim/models/Cart.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/screens/home/home_screen.dart';
import 'package:pim/size_config.dart';

class Body extends StatelessWidget {
  final List<Product> products;
  const Body(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: products.map((p) => itemProduit(p)).toList()));
  }
}

class itemProduit extends StatelessWidget {
  final Product product;
  const itemProduit(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              //"assets/images/download.jpg", height: 60, width: 60,
              'http://192.168.1.168/img/${product.image!}', height: 60,
              width: 60,
              // ajuster l'image pour remplir complètement le conteneur
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title ?? "title"),
                Text(product.description ?? "description"),
                Text(product.price.toString() + "dt")
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}
