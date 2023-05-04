class Api_Routes {
  static final String base = "http://192.168.43.98:9090/";
  static final String products_route = base + 'Produit/';
  static final String payment_route = base + 'payment/';
  static final String feedback_route = base + 'Ratings/';
  static final String user_route = base + 'user/';
  static final String commands_route = base + 'commande/';
  static final String reclamation_route = base + 'Reclam/';

  static final String get_all_products = products_route + 'getall';
  static final String get_all_Commands = commands_route + 'getid';
  static final String addCommand = commands_route + 'addcomande';
  static final String Payment_Pay = payment_route + 'pay';
  static final String get_product_ratings = feedback_route + 'getRatings';
  static final String add_product_rating = feedback_route + 'add';
  static final String add_Reclamation = reclamation_route + 'add';
}
