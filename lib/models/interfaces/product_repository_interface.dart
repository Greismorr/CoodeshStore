import 'package:coodesh_store/models/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getAllProducts();

  Future<List<String>> getAllCategories();

  Future<String> loadProductsIntoDatabase(String data);

  Future<String> saveProduct(Product product, bool pictureHasChanged);

  Future<String> deleteProduct(Product product);

  Future<String> saveCategory(String category, List<String> categoriesList);
}
