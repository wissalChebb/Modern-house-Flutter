import 'package:flutter/material.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/models/Cart.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/User.dart';

import 'package:pim/screens/detailCommand/detailComand_screen.dart';

import 'package:pim/screens/login_success/login_success_screen.dart';

class itemCommand extends StatefulWidget {
  const itemCommand({Key? key, this.cart}) : super(key: key);
  final Cart? cart;

  @override
  State<itemCommand> createState() => _itemCommandState();
}

class _itemCommandState extends State<itemCommand> {
  //User? user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailComandScreen.routeName,
        arguments: ProductsArguments(
            products: widget.cart!.products!, cart: widget.cart!),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            margin: EdgeInsets.only(bottom: 50),
            color: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Image.network(
                    '${Api_Routes.base}img/${widget.cart!.product!.image}',
                    height: 50, width: 50,
                    // ajuster l'image pour remplir complètement le conteneur
                  ),
                  SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.cart!.product!.category}"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("${widget.cart!.paid}"),
                          SizedBox(
                            width: 100,
                          ),
                          Text("${widget.cart!.etat}")
                        ],
                      ),
                      Text("${widget.cart!.date}")
                    ],
                  )
                ])),
          )),
    );
  }
}
