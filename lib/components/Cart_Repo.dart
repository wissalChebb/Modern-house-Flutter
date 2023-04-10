import 'dart:collection';

import 'package:pim/models/Cart.dart';
import 'package:pim/models/Product.dart';
import 'package:rxdart/rxdart.dart';

class Cart_Repo {
  List<Cart> _cardData = [];
  final _cartSubject = new BehaviorSubject<UnmodifiableListView<Cart>>();

  int get totalCartPrice => _totalPrice();

  Stream<UnmodifiableListView<Cart>> get CartData => _cartSubject.stream;

  void addToCart(Product product, int Quantity) {
    _cardData.add(Cart(id: product.id, product: product, numOfItem: Quantity));
    _cartSubject.add(UnmodifiableListView(_cardData));
  }

  void removeFromCart(String id) {
    _cardData.removeWhere((element) => element.id == id);
    _cartSubject.add(UnmodifiableListView(_cardData));
  }

  void clearCart() {
    _cardData.clear();
    _cartSubject.add(UnmodifiableListView(_cardData));
  }

  _totalPrice() {
    int total = 0;
    _cardData.forEach((element) {
      total += element.product.price;
    });
    return total;
  }
}
