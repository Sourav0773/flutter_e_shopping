import 'package:flutter/material.dart';
import 'package:e_shopping_app/Model/data_model.dart';

class CartModel extends ChangeNotifier {
  bool skeletonloader = false;

  final List<Products> cartItems = [];

  late Products selectedProduct;

  void stopSkeletonLoader() {
    skeletonloader = false;
    notifyListeners();
  }

  Future<void> startSkeletonLoader() async {
    skeletonloader = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 2000));
    stopSkeletonLoader();
  }

  void addToCart(Products product) {
    cartItems.add(product);
    //print('produtadded');
    notifyListeners();
  }

  void removeFromCart(Products product) {
    cartItems.remove(product);
    //print('iteremioved from cart');
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in cartItems) {
      total += product.price;
    }
    return total;
  }

  void selectProduct(Products product) {
    selectedProduct = product;
    notifyListeners();
  }
}
