import 'package:flutter/material.dart';
import '../models/food_model.dart';

class CartProvider with ChangeNotifier {

  final List<Food> _items = [];

  List<Food> get items => _items;

  void addToCart(Food food) {
    _items.add(food);
    notifyListeners();
  }

  void removeFromCart(Food food) {
    _items.remove(food);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var item in _items) {
      total += item.price;
    }

    return total;
  }
}