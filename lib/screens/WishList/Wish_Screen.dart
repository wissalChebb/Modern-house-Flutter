import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/components/coustom_bottom_nav_bar.dart';
// assuming that you have defined the Product class
import 'package:pim/enums.dart';
import 'package:pim/screens/forgot_password/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Wishlist.dart';
import '../../models/user.dart';

class WishListScreen extends StatefulWidget {
  static String routeName = "/wishlist";
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Product> _products = [];
  String? id = user?.id;
  @override
  void initState() {
    super.initState();
    _fetchProductswish(id);
  }

  Future _fetchProductswish(id) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse('http://localhost:9090/wishlist/getwishid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Charset': 'utf-8'
        },
        body: jsonEncode(<String, String>{
          'idUser': id,
        }),
      );

      if (response.statusCode == 200) {
        final wishlist = wishlistFromJson(response.body);
        final List<Product> productList = wishlist.products.toList();

        print(productList);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text(
            'Our Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return ListTile(
              title: Text(product.productname),
              subtitle: Text(product.description),
              leading:
                  Image.network("http://localhost:9090/img/" + product.image),
              trailing: Text('\$${product.price.toStringAsFixed(2)}'),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
