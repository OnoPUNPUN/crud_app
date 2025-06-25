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

  Future<bool> createUpdateProducts(
    String productName,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
    String? productId,
    bool isUpdate,
  ) async {
    final response = await http.post(
      Uri.parse(
        isUpdate ? Urls.updateProductUrl(productId!) : Urls.createProductUrl,
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<void> createProducts(
    String productName,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProductUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<bool> deleteProducts(String productId) async {
    final response = await http.get(
      Uri.parse(Urls.deleteProductUrl(productId)),
    );

    if (response.statusCode == 200) {
      fetchProducts();
      return true;
    } else {
      return false;
    }
  }
}
