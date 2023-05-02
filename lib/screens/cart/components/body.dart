import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pim/components/global_repos.dart';
import 'package:pim/models/Cart.dart';

import 'package:pim/models/Product.dart';

import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: StreamBuilder<UnmodifiableListView<Cart>>(
        stream: cart_repo.CartData,
        initialData: UnmodifiableListView([]),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(snapshot.data![index].product!.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cart_repo.removeFromCart(snapshot.data![index].id!);
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cart: snapshot.data![index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
