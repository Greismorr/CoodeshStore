import 'dart:io';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';
import 'package:coodesh_store/models/interfaces/database_api_interface.dart';
import 'package:coodesh_store/models/interfaces/product_repository_interface.dart';
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
  Future<http.Response> _mockListRequest(http.Request request) async {
    if (request.url
        .toString()
        .startsWith('https://jsonplaceholder.typicode.com/products/')) {
      return http.Response(
        File('test/test_resources/product_sample.json').readAsStringSync(),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
    }
    return http.Response('Error: Unknown endpoint', 404);
  }

  return _mockListRequest;
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
  // Registra lazy singletons para injeção de dependências.
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
    'Test List of Products',
    () async {
      final dependencies = GetIt.instance;
      _registerDependencies(dependencies);

      final repository = GetIt.instance<IProductRepository>();
      final productList = (await repository.getAllProducts());

      productList.asMap().forEach((index, product) {
        expect(product.id, index.toString());
        expect(product.title, 'Test Product');
        expect(product.description, "Just a Test Product");
        expect(product.picture, PLACEHOLDER_IMAGE);
        expect(product.price, 25.0);
        expect(product.rating, 5);
        expect(product.type, "test");
      });
    },
  );
}
