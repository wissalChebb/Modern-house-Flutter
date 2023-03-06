import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/components/coustom_bottom_nav_bar.dart';
import 'package:pim/models/Product.dart'; // assuming that you have defined the Product class
import 'package:pim/enums.dart';
import 'package:pim/models/user.dart';

class ProductListScreen extends StatefulWidget {
  static String routeName = "/produit";
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  String? id = user?.id;
  String? productId = product?.id;
  List<String> _categories = [
    'seramic',
    'flooring',
    'electrical',
    'kitchen',
    'lighting',
    'masonry',
    'paints',
    'walls',
  ];
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:9090/produit/getall'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        print(jsonList);
        final List<Product> productList =
            jsonList.map((json) => Product.fromJson(json)).toList();
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

  Future<void> _addToWishlist(id, productId) async {
    try {
      final url = Uri.parse('http://localhost:9090/wishlist/addwish');
      final response = await http.post(url, body: {
        'idproduct': productId,
        'idUser': id,
      });
    } catch (e) {
      print(e);
    }
  }

  void _sortProductsByCategory(String category) async {
    try {
      final url = Uri.parse('http://localhost:9090/produit/getbycategory');
      final response = await http.post(url, body: {
        'category': category,
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
            return Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 85, 77, 77),
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Image.network(
                    "http://localhost:9090/img/" + product.image,
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          product.productname,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Add to cart action
                                  },
                                  icon: Icon(Icons.add_shopping_cart),
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8.0),
                                IconButton(
                                  onPressed: () {
                                    _addToWishlist(user?.id, product.id);
                                  },
                                  icon: Icon(Icons.favorite_border),
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
