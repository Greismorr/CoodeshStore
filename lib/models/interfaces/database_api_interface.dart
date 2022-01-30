import 'package:coodesh_store/models/product.dart';

abstract class IDatabaseApi {
  Map<String, String> getServerTimestamp();

  Future<List<Product>> getAllProducts();

  Future<List<String>> getAllCategories();

  Future<String> saveCategoriesList(List<String> categoriesList);

  Future<String> saveProductMap(Map<String?, Map<String, dynamic>> productMap);

  Future<String> saveProduct(Product product);

  Future<String> deleteProduct(Product product);

  Future<String> saveCategory(String category, String position);
}
