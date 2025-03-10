import 'package:e_shopping_app/Model/data_model.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  bool skeletonloader = false;
  final List<Products> _cartItems = [];
  List<Products> get cartItems => _cartItems;
  late Products _selectedProduct;
  Products get selectedProduct => _selectedProduct;

  void stopSkeletonLoader() {
    skeletonloader = false;
    notifyListeners();
  }

  Future<void> startSkeletonLoader() async {
    skeletonloader = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1400));
    stopSkeletonLoader();
  }

  void addToCart(Products product) {
    _cartItems.add(product);
    //print('produtadded');
    notifyListeners();
  }

  void removeFromCart(Products product) {
    _cartItems.remove(product);
    //print('iteremioved from cart');
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in _cartItems) {
      total += product.price;
    }
    return total;
  }

  void selectProduct(Products product) {
    _selectedProduct = product;
    notifyListeners(); 
  }
}
