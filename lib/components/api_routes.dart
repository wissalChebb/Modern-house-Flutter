class Api_Routes {
  static final String base = "http://172.16.6.170:9090/";
  static final String products_route = base + 'Produit/';
  static final String payment_route = base + 'payment/';

  static final String get_all_products = products_route + 'getall';
  static final String Payment_Pay = payment_route + 'pay';
}
