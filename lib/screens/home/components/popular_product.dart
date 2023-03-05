import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pim/models/Product.dart';
import 'package:pim/screens/home/components/section_title.dart';

import '../../../size_config.dart'; // assuming that you have defined the Product class

class PopularProducts extends StatefulWidget {
  @override
  _PopularProducts createState() => _PopularProducts();
}

class _PopularProducts extends State<PopularProducts> {
  List<Product> _products = [];

  @override
  void initState() {
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:9090/produit/getall'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<Product> productList =
            jsonList.map((json) => Product.fromJson(json)).toList();

        setState(() {
          _products = productList;
        });
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              _products.length,
              (index) {
                final product = _products[index];
                return Container(
                  margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    top: getProportionateScreenWidth(20),
                    bottom: getProportionateScreenWidth(20),
                  ),
                  width: getProportionateScreenWidth(140),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.02,
                        /*child: Image.network(
                            "http://localhost:9090/img/" + product.image),*/
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenWidth(5),
                        ),
                        child: Text(
                          _products[index].productname,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenWidth(5),
                        ),
                        child: Text(
                          '\$${_products[index].price}',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
