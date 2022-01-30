import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/product.dart';
import 'firebase_childs.dart';

class FirebaseApi implements IDatabaseApi {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  DatabaseReference productsRef =
      FirebaseDatabase.instance.ref().child(productsChild);
  DatabaseReference categoriesRef =
      FirebaseDatabase.instance.ref().child(categoriesChild);

  @override
  Map<String, String> getServerTimestamp() {
    return ServerValue.timestamp;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    DatabaseEvent event = await productsRef.once();

    List<Product> productList = [];

    event.snapshot.children.forEach((product) {
      productList.add(Product.fromJson(jsonDecode(jsonEncode(product.value))));
    });

    return productList;
  }

  @override
  Future<List<String>> getAllCategories() async {
    DatabaseEvent event = await categoriesRef.once();

    List<String> categoriesList = [];

    event.snapshot.children.forEach(
      (category) {
        //Adiciona na lista de categorias uma Produto a partir do json em product.value
        categoriesList.add(category.value.toString());
      },
    );

    return categoriesList;
  }

  @override
  Future<String> saveCategoriesList(List<String> categoriesList) async {
    try {
      await categoriesRef.set(categoriesList);
      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }

  @override
  Future<String> saveProductMap(
      Map<String?, Map<String, dynamic>> productMap) async {
    try {
      await productsRef.set(productMap);

      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }

  @override
  Future<String> saveProduct(Product product) async {
    try {
      await productsRef.child(product.id).set(product.toJson());

      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }

  @override
  Future<String> deleteProduct(Product product) async {
    try {
      await productsRef.child(product.id).remove();

      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }

  @override
  Future<String> saveCategory(String newCategory, String position) async {
    try {
      await categoriesRef.child(position).set(newCategory);

      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }
}
