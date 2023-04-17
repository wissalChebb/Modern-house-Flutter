class Api_Routes {
  static final String base = "http://172.16.2.241:9090/";
  static final String products_route = base + 'Produit/';
  static final String payment_route = base + 'payment/';
  static final String feedback_route = base + 'Ratings/';
  static final String user_route = base + 'user/';

  static final String get_all_products = products_route + 'getall';
  static final String Payment_Pay = payment_route + 'pay';
  static final String get_product_ratings = feedback_route + 'getRatings';
  static final String add_product_rating = feedback_route + 'add';
}
