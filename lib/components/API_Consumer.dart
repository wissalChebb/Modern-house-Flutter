import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/models/Product.dart';
import 'package:rxdart/rxdart.dart';

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

  API_Consumer() {
    getAllProducts();
  }
}
