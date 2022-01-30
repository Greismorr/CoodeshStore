import 'package:coodesh_store/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/main.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/repositories/products_repository.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product.dart';
import 'package:coodesh_store/ui/screens/market_home_page.dart';

class AppRouter {
  final ProductsRepository productsRepository = new ProductsRepository();
  late final ProductBloc productBloc;

  AppRouter() {
    productBloc = ProductBloc(productsRepository: productsRepository);
  }

  navigateTo(String routeName, dynamic arguments) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: productBloc,
            child: MarketHomePage(),
          ),
        );

      case PRODUCT_EDIT:
        final Product product = routeSettings.arguments as Product;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: productBloc,
            child: EditProduct(
              product: product,
            ),
          ),
        );

      default:
        return null;
    }
  }

  void dispose() {
    productBloc.close();
  }
}
