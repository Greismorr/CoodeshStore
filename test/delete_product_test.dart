import 'dart:io';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/interfaces/product_repository_interface.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/repositories/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'cloud_image_api_provider.dart';
import 'database_api_provider.dart';

Future<Response> Function(Request) _createDatabaseMockClient() {
  Future<http.Response> _mockDeleteRequest(http.Request request) async {
    if (request.url
        .toString()
        .startsWith('https://jsonplaceholder.typicode.com/products/')) {
      return http.Response(
        '$SUCCESS',
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
    }
    return http.Response('Error: Unknown endpoint', 404);
  }

  return _mockDeleteRequest;
}

Future<Response> Function(Request) _createCloudImageClient() {
  Future<http.Response> _mockDeleteRequest(http.Request request) async {
    if (request.url
        .toString()
        .startsWith('https://jsonplaceholder.typicode.com/products/images')) {
      return http.Response(
        '$SUCCESS',
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
    }
    return http.Response('Error: Unknown endpoint', 404);
  }

  return _mockDeleteRequest;
}

void _registerDependencies(GetIt dependency) {
  // Registra singletons para injeção de dependências.
  dependency.registerLazySingleton<IDatabaseApi>(
    () => DatabaseApiProvider(MockClient(_createDatabaseMockClient())),
  );

  dependency.registerLazySingleton<IProductRepository>(
    () => ProductsRepository(),
  );

  dependency.registerLazySingleton<ICloudImageApi>(
    () => CloudImageApiProvider(MockClient(_createCloudImageClient())),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test(
    'Test Delete Product Operation',
    () async {
      final dependencies = GetIt.instance;
      _registerDependencies(dependencies);

      final repository = GetIt.instance<IProductRepository>();
      final Product product = Product(
        id: '1',
        title: 'Test',
        description: "A Test Product",
        picture: PLACEHOLDER_IMAGE,
        price: 15.60,
        rating: 5,
        type: 'meat',
      );

      expect(await repository.deleteProduct(product), SUCCESS);
    },
  );
}
