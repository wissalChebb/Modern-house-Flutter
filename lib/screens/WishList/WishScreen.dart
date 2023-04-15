import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/components/coustom_bottom_nav_bar.dart';
// assuming that you have defined the Product class
import 'package:pim/enums.dart';
import 'package:pim/screens/forgot_password/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Product.dart';
import '../../models/Wishlist.dart';
import '../../models/user.dart';

class WishlistScreen extends StatefulWidget {
  static String routeName = "/Wishlist";
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Productw> _products = [];
  String? id = user?.id;
  String? productId = product?.id;
  @override
  void initState() {
    super.initState();
    if (id != null) {
      _fetchProductswish(id);
    }
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
        final List<Productw> productList = wishlist.products.toList();

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

  Future<void> _deleteProduct(id, productId) async {
    try {
      final url = Uri.parse('http://localhost:9090/wishlist/deletewish');
      final response = await http.delete(url, body: {
        'userId': id,
        'productId': productId,
      });
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
            'Wish List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product information
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // delete button
                    IconButton(
                      icon: Icon(Icons.delete_rounded, color: Colors.red),
                      onPressed: () {
                        _deleteProduct(user?.id, product.id);
                        setState(() {
                          _products.remove(product);
                        });
                      },
                    ),
                    // product image
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'http://localhost:9090/img/${product.image}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
