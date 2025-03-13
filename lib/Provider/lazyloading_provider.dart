//not used yet

import 'package:e_shopping_app/API/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:e_shopping_app/Model/data_model.dart';

class PaginationModel extends ChangeNotifier {
  final apiService = ApiService();

  List<Products> items = [];

  bool isLoading = false;
  int page = 1;
  int limit = 10;
  bool hasMore = true;

  Future<void> fetchItems() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    try {
      List<Products> newItems = await apiService.fetchProductData(page, limit);
      if (newItems.isEmpty) {
        hasMore = false;
      } else {
        items.addAll(newItems);
        page++;
      }
    } catch (e) {
      print("Error fetching posts $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}


























/*import 'package:e_shopping_app/Model/data_model.dart';
import 'package:flutter/material.dart';

class PaginationModel extends ChangeNotifier {
 final List<Products> _items = [];
  //List<Products> get cartItems => _items;
  bool isLoading = false;
  int currentPage = 1;

  Future<void> fetchItems() async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 2)); 
      final newItems = List.generate(10, (index) => 'Item ${(currentPage - 1) * 10 + index + 1}');
      _items.addAll(newItems as Iterable<Products>);
      currentPage++;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}*/