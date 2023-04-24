import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pim/components/Cart_Repo.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Rate.dart';
import 'package:pim/models/user.dart';
import 'package:pim/screens/payment_web_view.dart';
import 'package:rxdart/rxdart.dart';

import 'global_repos.dart';

class API_Consumer {
  List<Product> _all_products = [];
  List<Rate> _product_rates = [];

  final _productsSubject = new BehaviorSubject<UnmodifiableListView<Product>>();

  final _productRatesSubject =
      new BehaviorSubject<UnmodifiableListView<Rate>>();

  Stream<UnmodifiableListView<Product>> get Products => _productsSubject.stream;
  Stream<UnmodifiableListView<Rate>> get Rates => _productRatesSubject.stream;

  Future<Null> getProductRates(product_id) async {
    _productRatesSubject.add(UnmodifiableListView([]));
    Response response = await post(Uri.parse(Api_Routes.get_product_ratings),
        body: {"product_id": product_id});
    print(response.body);
    Map<String,dynamic> bodyData = json.decode(response.body);

    _product_rates = (bodyData['Ratings'] as List<dynamic>).map((e) => Rate.fromJson(e)).toList();
   // _product_sum = (bodyData['sum'] as List<dynamic>).map((e) => Rate.fromJson(e)).toList();
    _productRatesSubject.add(UnmodifiableListView(_product_rates));

  }

  Future<Null> addRate(
      {product_id, rate, feedback, VoidCallback? onDone}) async {
    Response response =
        await post(Uri.parse(Api_Routes.add_product_rating), body: {
      "product_id": product_id,
      "rate": rate.toString(),
      "feedback": feedback,
      "idUser": user!.id
    });
    print(response.body);
    response.statusCode == 200 ? onDone!() : null;
  }

  Future<User> getUserInfo({required String userID}) async{
    Response respone = await get(Uri.parse(Api_Routes.user_route+userID));
    print('data'+respone.body);
    return User.fromJson(json.decode(respone.body));
  }

  Future<Null> getAllProducts() async {
    Response response = await get(Uri.parse(Api_Routes.get_all_products));

    List<dynamic> bodyData = json.decode(response.body);

    _all_products = bodyData.map((e) => Product.fromJson(e)).toList();
    _productsSubject.add(UnmodifiableListView(_all_products));
  }

  Future<Null> createPaymentRequest(BuildContext context) async {
    Response response = await post(Uri.parse(Api_Routes.Payment_Pay), body: {
      "prix": (cart_repo.totalCartPrice * 1000).toString(),
      "first_name": user!.username,
      "last_name": " ",
      "email": user!.email
    });
    Map<String, dynamic> data = json.decode(response.body);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentWebView(paymen_url: data['data']['payUrl'])));
  }

  API_Consumer() {
    getAllProducts();
  }
}
