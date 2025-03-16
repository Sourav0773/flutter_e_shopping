import 'package:e_shopping_app/Model/data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final dio = Dio();
  final String baseURL = 'https://emobile-fzbygfa6bdfjaac4.centralindia-01.azurewebsites.net/Api/getProducts';

  Future<List<Products>> fetchProductData() async {
    try {
      Response response = await dio.get(baseURL);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Raw API Response: ${response.data.toString()}");
        }
        List<dynamic> data = response.data;
        List<Products> products = data.map((json) => Products.fromJson(json)).toList();
        if (kDebugMode) {
          print("Number of products fetched: ${products.length}");
        }
        for (var product in products) {
          if (kDebugMode) {
            print("Product: ${product.pname}, Price: ${product.price}");
          }
        } return products;
      } else {
        if (kDebugMode) {
          print("Failed to load data, Status Code: ${response.statusCode}");
        }
        throw Exception("Failed to load data");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception("Error:$e");
    }
  }
}
