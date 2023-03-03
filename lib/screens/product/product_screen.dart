import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/components/coustom_bottom_nav_bar.dart';
import 'package:pim/models/Product.dart'; // assuming that you have defined the Product class
import 'package:pim/enums.dart';

class ProductListScreen extends StatefulWidget {
  static String routeName = "/produit";
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text(
            'Our Product',
            style: TextStyle(fontWeight: FontWeight.bold,
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
