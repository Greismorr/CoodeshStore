import 'dart:convert';
import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/interfaces/product_repository_interface.dart';
import 'package:coodesh_store/models/mixins/have_image_asset.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:get_it/get_it.dart';

class ProductsRepository with HaveImageOnAssets implements IProductRepository {
  final databaseApi = GetIt.I<IDatabaseApi>();
  final cloudImageApi = GetIt.I<ICloudImageApi>();

  @override
  Future<List<Product>> getAllProducts() async {
    return databaseApi.getAllProducts();
  }

  @override
  Future<List<String>> getAllCategories() async {
    return databaseApi.getAllCategories();
  }

  @override
  Future<String> loadProductsIntoDatabase(String data) async {
    try {
      final Map<String?, Map<String, dynamic>> productMap = {};
      List<String> categoriesList = [];
      List productsDecoded = jsonDecode(data);

      //Carrega productList com Produtos criados a partir do json local
      for (int count = 0; count < productsDecoded.length; count++) {
        var productJson = productsDecoded[count];

        Product product = Product.fromAssetJson(
          json: productJson,
          id: count.toString(),
          createdAt: databaseApi.getServerTimestamp(),
        );

        //Cria um arquivo temporário da imagem do produto presente nos assets
        //para conseguir um path válido e salvá-la na nuvem. Este trecho foi
        //utilizado para enviar as imagens para o Cloudinary. Está comentado por
        //agora ser desnecessário, já que só precisei rodá-lo uma vez, mas vale o registro.
        /* 
          File imageTemp = await getImageFileFromAssets('${product.id}.jpg');

          product.picture = await cloudImageApi.saveOnCloud(imageTemp.path,
              fileName: product.id);
        */

        productMap[product.id] = product.toJson();

        //Adiciona a categoria à lista caso ela ainda não tenha sido inserida.
        if (!categoriesList.contains(product.type)) {
          categoriesList.add(product.type);
        }
      }

      await databaseApi.saveProductMap(productMap);
      await databaseApi.saveCategoriesList(categoriesList);
      return SUCCESS;
    } catch (e) {
      print(e);
      return FAILURE;
    }
  }

  @override
  Future<String> saveProduct(Product product, bool pictureHasChanged) async {
    product.createdAt = databaseApi.getServerTimestamp();

    if (pictureHasChanged) {
      if (product.picture != null && product.picture!.isNotEmpty) {
        product.picture = await cloudImageApi
            .saveOnCloud(product.picture as String, fileName: product.id);
      }
    }

    return await databaseApi.saveProduct(product);
  }

  @override
  Future<String> deleteProduct(Product product) async {
    if (await databaseApi.deleteProduct(product) == SUCCESS) {
      //Deleta a imagem do produto salva na nuvem
      if (await cloudImageApi.deleteOfCloud(product.picture as String)) {
        return SUCCESS;
      }
    }
    return FAILURE;
  }

  @override
  Future<String> saveCategory(
      String category, List<String> categoriesList) async {
    return await databaseApi.saveCategory(
        category, categoriesList.length.toString());
  }
}
