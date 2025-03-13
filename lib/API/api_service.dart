//TRIAL CODE///////////
import 'package:e_shopping_app/Model/data_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();
  final String baseURL =
      'https://emobile-fzbygfa6bdfjaac4.centralindia-01.azurewebsites.net/Api/getProducts';

  Future<List<Products>> fetchProductData(int page, int limit) async {
    try {
      Response response = await dio.get(
        '$baseURL?_page=$page&_limit=$limit',
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Products.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }
}

//ORIGINAL CODE///
/*import 'package:e_shopping_app/Model/data_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();
  final String baseURL =
      'https://emobile-fzbygfa6bdfjaac4.centralindia-01.azurewebsites.net/Api/getProducts';

  Future<List<Products>> fetchProductData() async {
    try {
      Response response = await dio.get(
        baseURL,
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Products.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }
}*/
