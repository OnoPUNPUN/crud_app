import 'dart:convert';

import 'package:crud_app/utils/urls.dart';

import '../Models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProductUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<bool> deleteProducts(String productId) async {
    final response = await http.get(
      Uri.parse(Urls.deleteProductUrl(productId)),
    );

    if (response.statusCode == 200) {
      fetchProducts();
      return true;
    } else{
      return false;
    }
  }
}
