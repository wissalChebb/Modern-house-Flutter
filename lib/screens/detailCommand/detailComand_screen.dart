import 'package:flutter/material.dart';
import 'package:pim/models/Cart.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/screens/Reclamation/reclamation_Screen.dart';
import 'package:pim/screens/detailCommand/Body.dart';

class DetailComandScreen extends StatelessWidget {

  static String routeName = "/detailCommandScreen";
  @override
  Widget build(BuildContext context) {
    final ProductsArguments agrs = ModalRoute.of(context)!.settings.arguments as ProductsArguments;
    return Scaffold(
      appBar: AppBar(

        title: Text('My Product',style:TextStyle(color: Colors.black),),

      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add you'r claime"),
              InkWell(
                child: Icon(Icons.link),
                onTap: () => Navigator.pushNamed(
                  context,
                  ReclamationScreen.routeName,
                  arguments:  agrs.cart,
                ),
              ),
            ],
          ),

          Body(agrs.products)
        ],
      )


    );
  }
}

class ProductsArguments {
  final List<Product> products;
  final Cart cart;

  ProductsArguments({required this.products, required this.cart});
}
