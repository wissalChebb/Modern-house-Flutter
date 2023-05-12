import 'dart:collection';

import 'package:pim/models/Product.dart';
import 'package:rxdart/rxdart.dart';

import '../models/Cart.dart';

class Cart_Repo {
  List<Cart> cardData = [];
  final _cartSubject = new BehaviorSubject<UnmodifiableListView<Cart>>();
  double? totalwithdiscount;
  int get totalCartPrice => _totalPrice();

  Stream<UnmodifiableListView<Cart>> get CartData => _cartSubject.stream;

  void addToCart(Product product, int Quantity) {
    cardData.add(Cart(id: product.id, product: product, numOfItem: Quantity));
    _cartSubject.add(UnmodifiableListView(cardData));
  }

  void removeFromCart(String id) {
    cardData.removeWhere((element) => element.id == id);
    _cartSubject.add(UnmodifiableListView(cardData));
  }

  void clearCart() {
    cardData.clear();
    _cartSubject.add(UnmodifiableListView(cardData));
  }

  _totalPrice() {
    int total = 0;
    cardData.forEach((element) {
      total += element.product!.price!;
    });
    return total;
  }
}
