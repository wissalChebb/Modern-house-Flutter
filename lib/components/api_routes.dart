class Api_Routes {
  static final String base = "http://localhost:9090/";
  static final String products_route = base + 'produit/';
  static final String payment_route = base + 'payment/';

  static final String get_all_products = products_route + 'getall';
  static final String Payment_Pay = payment_route + 'pay';
}
