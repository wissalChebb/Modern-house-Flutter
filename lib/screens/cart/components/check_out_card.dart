import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/components/default_button.dart';
import 'package:pim/components/global_repos.dart';
import 'package:http/http.dart' as http;
import 'package:pim/models/CodePromo.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../models/user.dart';

class CheckoutCard extends StatefulWidget {
  final String product_id;
  final String idUser;
  const CheckoutCard(
      {super.key, required this.product_id, required this.idUser});

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                //haseeeeeeeeeen
                Container(
                  width: 200,
                  height: 50, // Set the desired width here
                  child: TextField(
                    style: TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      labelText: "code",
                      hintText: "Enter your Code",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    controller: _textController,
                    // Add any other properties you need for the TextField here
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    VerifCode(context, _textController.text);
                    print('Icon button pressed');
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            StreamBuilder(
                stream: cart_repo.CartData,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text:
                                  "\$ ${cart_repo.totalCartPrice - ((cart_repo.totalCartPrice * c!.discount) / 100)}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: DefaultButton(
                          text: "Check Out",
                          press: () {
                            if (snapshot.data!.isNotEmpty) {
                              apiData.addCart(
                                idUser: widget.idUser,
                                product_id: widget.product_id,
                                onDone: () {},
                              );
                              // apiData.createPaymentRequest(context);
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

void _showPopupMessage(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

Future VerifCode(context, code) async {
// obtain shared preferences

  final response = await http.post(
    Uri.parse('${Api_Routes.base}Promo/check/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'code': code, 'idUser': user!.id!}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    c = CodePromo.fromJson(jsonDecode(response.body));
    if (c!.active) {
      _showPopupMessage(
          context, "Your Code Is Correct", "Your Code Is Activated !");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      _showPopupMessage(context, "Try Again", "This Code Is Already Used  !");
      throw Exception('Failed to create album.');
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    _showPopupMessage(context, "Try Again", "This Code Is Already Used  !");
  }
}
