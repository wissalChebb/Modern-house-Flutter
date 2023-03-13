import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pim/components/Cart_Repo.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/user.dart';
import 'package:pim/screens/payment_web_view.dart';
import 'package:rxdart/rxdart.dart';

import 'global_repos.dart';

class API_Consumer {
  List<Product> _all_products = [];

  final _productsSubject = new BehaviorSubject<UnmodifiableListView<Product>>();

  Stream<UnmodifiableListView<Product>> get Products => _productsSubject.stream;

  Future<Null> getAllProducts() async {
    Response response = await get(Uri.parse(Api_Routes.get_all_products));

    List<dynamic> bodyData = json.decode(response.body);

    _all_products = bodyData.map((e) => Product.fromJson(e)).toList();
    _productsSubject.add(UnmodifiableListView(_all_products));
  }

  Future<Null> createPaymentRequest(BuildContext context) async{
    Response response = await post(Uri.parse(Api_Routes.Payment_Pay),body: {
      "prix"  : (cart_repo.totalCartPrice*1000).toString(),
      "first_name" : user!.username,
      "last_name" : " ",
      "email" : user!.email
    });
    Map<String, dynamic> data = json.decode(response.body);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentWebView(paymen_url: data['data']['payUrl']) ) );
  }

  API_Consumer() {
    getAllProducts();
  }
}
