import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/models/Cart.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Rate.dart';
import 'package:pim/models/user.dart';
import 'package:pim/screens/payment_web_view.dart';
import 'package:rxdart/rxdart.dart';
import 'global_repos.dart';

class API_Consumer {
  List<Product> _all_products = [];
  List<Rate> _product_rates = [];
  List<Cart> _all_Command = [];

  final _productsSubject = new BehaviorSubject<UnmodifiableListView<Product>>();
  final _commandsSubject = new BehaviorSubject<UnmodifiableListView<Cart>>();
  final _productRatesSubject =
      new BehaviorSubject<UnmodifiableListView<Rate>>();
  Stream<UnmodifiableListView<Cart>> get Commands => _commandsSubject.stream;
  Stream<UnmodifiableListView<Product>> get Products => _productsSubject.stream;
  Stream<UnmodifiableListView<Rate>> get Rates => _productRatesSubject.stream;

  /***/
  static Future<List<Cart>> getCommandUserFromBackend() async {
    var response = await post(Uri.parse(Api_Routes.get_all_Commands),
        body: {"idUser": user!.id});
    var jsonDecode = json.decode(response.body);
    return jsonDecode.map((e) {
      print("wissal mapping");
      print(e);
      var cart = Cart.fromJson(e);
      print(cart.product);
      return Cart.fromJson(e);
    }).toList();
  }

  /***/

  Future<Null> getCommandUser(userId) async {
    _commandsSubject.add(UnmodifiableListView([]));
    print("hahahaha");
    Response response = await post(Uri.parse(Api_Routes.get_all_Commands),
        body: {"user": userId});
    print(response.body);
    //List< dynamic> bodyData = json.decode(response.body);

    //_all_Command=bodyData.map((e) => Cart.fromJson(e) as MapEntry Function(String key, dynamic value)).toList();
    //_all_Command =  bodyData.map((e) => Cart.fromJson(e)).toList();
    // _product_sum = (bodyData['sum'] as List<dynamic>).map((e) => Rate.fromJson(e)).toList();
    _commandsSubject.add(UnmodifiableListView(_all_Command));
  }

  Future<Null> getAllProducts() async {
    Response response = await get(Uri.parse(Api_Routes.get_all_products));

    List<dynamic> bodyData = json.decode(response.body);

    _all_products = bodyData.map((e) => Product.fromJson(e)).toList();
    _productsSubject.add(UnmodifiableListView(_all_products));
  }

  Future<Null> getProductRates(product_id) async {
    _productRatesSubject.add(UnmodifiableListView([]));
    Response response = await post(Uri.parse(Api_Routes.get_product_ratings),
        body: {"product_id": product_id});
    print(response.body);
    Map<String, dynamic> bodyData = json.decode(response.body);

    _product_rates = (bodyData['Ratings'] as List<dynamic>)
        .map((e) => Rate.fromJson(e))
        .toList();
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

  Future<Null> addCart({product_id, idUser, VoidCallback? onDone}) async {
    Response response = await post(Uri.parse(Api_Routes.addCommand),
        body: {"product_id": product_id, "idUser": user!.id});
    print(response.body);
    response.statusCode == 200 ? onDone!() : null;
  }

  Future<Null> addReclamation(
      {idUser, idcart, description, sujet, VoidCallback? onDone}) async {
    print("wissal chebbi a");
    print(description);
    print(sujet);
    Response response = await post(Uri.parse(Api_Routes.add_Reclamation),
        body: {
          "description": description,
          "idcart": idcart,
          "idUser": user!.id,
          "sujet": sujet
        });
    print(response.body);
    response.statusCode == 200 ? onDone!() : null;
  }

  Future<User> getUserInfo({required String userID}) async {
    Response respone = await get(Uri.parse(Api_Routes.user_route + userID));
    print('data' + respone.body);
    return User.fromJson(json.decode(respone.body));
  }

  Future<Null> createPaymentRequest(BuildContext context) async{
    Response response = await post(Uri.parse(Api_Routes.Payment_Pay),body: {
      "prix"  : (cart_repo.totalCartPrice*1000).toString(),
      "first_name" : user!.username,
      "last_name" : " ",
      "email" : user!.email
    });
    Map<String, dynamic> data = json.decode(response.body);
   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentWebView(paymen_url: data['data']['payUrl']) ) );
  }


  API_Consumer() {
    getAllProducts();
    getCommandUser("");
  }
}
