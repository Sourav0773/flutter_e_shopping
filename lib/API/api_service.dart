import 'package:e_shopping_app/model/data_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();
  int currentPage = 1;
  final int itemsPerPage = 20;
  final String baseURL =
      'https://emobile-fzbygfa6bdfjaac4.centralindia-01.azurewebsites.net/Api/getProducts';

  Future<List<Product>> fetchProductData({int page = 1}) async {
    try {
      Response response = await dio.get(
        baseURL,
        queryParameters: {
          'page': page,
          'limit': itemsPerPage,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        if (data.isEmpty) {
          return [];
        }
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }

  Future<List<Product>> fetchNextPage() async {
    List<Product> newProducts = await fetchProductData(page: currentPage + 1);
    if (newProducts.isEmpty) {
      currentPage++;
    }
    return newProducts;
  }

  void resetPagination() {
    currentPage = 1;
  }
}
