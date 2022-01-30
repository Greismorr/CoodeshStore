import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class DatabaseApiProvider implements IDatabaseApi {
  final Client client;

  DatabaseApiProvider(this.client);

  Future<String> deleteProduct(Product product) async {
    try {
      final response = await client.delete(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/products/${product.id}'),
      );

      if (response.statusCode == 200) {
        return SUCCESS;
      }
    } catch (e) {
      print(e);
    }

    return FAILURE;
  }

  @override
  Future<List<String>> getAllCategories() {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/products/1'),
    );

    List<Product> productList = [];
    List<dynamic> productListFromJson = jsonDecode(response.body);
    productListFromJson.forEach((product) {
      productList.add(Product.fromJson(product));
    });

    return productList;
  }

  @override
  Map<String, String> getServerTimestamp() {
    throw UnimplementedError();
  }

  @override
  Future<String> saveCategoriesList(List<String> categoriesList) {
    throw UnimplementedError();
  }

  @override
  Future<String> saveCategory(String category, String position) {
    throw UnimplementedError();
  }

  @override
  Future<String> saveProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<String> saveProductMap(Map<String?, Map<String, dynamic>> productMap) {
    throw UnimplementedError();
  }
}
