import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/ui/screens/loading/loading_product_list.dart';
import 'package:coodesh_store/widgets/app_bar_widget.dart';
import 'package:coodesh_store/widgets/bottom_bar_widget.dart';
import 'package:coodesh_store/widgets/circular_progress_widget.dart';
import 'package:coodesh_store/widgets/empty_list_widget.dart';
import 'package:coodesh_store/widgets/error_message_widget.dart';
import 'package:coodesh_store/widgets/market_product_widget.dart';
import 'package:coodesh_store/widgets/show_error.dart';
import 'package:coodesh_store/widgets/show_info.dart';
import 'package:uiblock/uiblock.dart';

class MarketHomePage extends StatefulWidget {
  @override
  _MarketHomePageState createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {
  final ScrollController scrollController = ScrollController();
  final String errorMessage = "Something's went wrong 😭";
  final String jsonImportedWithSuccessMessage =
      "Your JSON file was imported successfully! 😁";
  final String importingJsonMessage =
      "Importing your products from JSON file. Please, wait 😁";
  final String deletedProductMessage =
      "Product deleted from database successfully! 😁";
  final String deletingProductMessage = "Deleting product. Please, wait 😁";
  final emptyListTitle = "There's no items in the database 😥";
  final emptyListSubTitle =
      'Click on the button to load the json into the database';
  final errorMessageTitle = "Something's went wrong... 😥";
  final errorMessageSubtitle = "Try again another time";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  late ProductBloc productBloc;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _importProductsFromJson(BuildContext context) async {
    final String productsAssetsPath = "assets/products.json";

    String data =
        await DefaultAssetBundle.of(context).loadString(productsAssetsPath);

    productBloc.add(ImportingProductsFromJsonEvent(data: data));
  }

  @override
  Widget build(BuildContext context) {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ProductsLoadingEvent());

    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        hasPreviousScreen: false,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          return productBloc.add(ProductsLoadingEvent());
        },
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ErrorOnLoadingProductsState ||
                state is ErrorDeletingProductState) {
              //Esconde a snackbar atual para que a mostrada na tela
              //seja sempre a mais recente.
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              showError(errorMessage, context);
              UIBlock.unblock(context);
            } else if (state is SuccessOnImportingProductsState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              showInfo(jsonImportedWithSuccessMessage, context);
              UIBlock.unblock(context);
            } else if (state is ImportingProductsFromJsonState) {
              showInfo(importingJsonMessage, context);
              UIBlock.block(
                context,
                safeAreaTop: false,
                customLoaderChild: CircularProgressWidget(
                  width: 5.0,
                ),
              );
            } else if (state is ProductBeingDeletedState) {
              Navigator.pop(context);
              showInfo(deletingProductMessage, context);
              UIBlock.block(
                context,
                safeAreaTop: false,
                customLoaderChild: CircularProgressWidget(
                  width: 5.0,
                ),
              );
            } else if (state is ProductDeletedState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              showInfo(deletedProductMessage, context);
              UIBlock.unblock(context);

              //Chamando o setState, a snackbar seria escondida assim que a tela
              //fosse reconstruída.
              productBloc.add(ProductsLoadingEvent());
            } else if (state is ErrorOnLoadingProductsState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              showError(errorMessage, context);
              UIBlock.unblock(context);
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductsLoadedState) {
                if (state.productList.isEmpty) {
                  return Center(
                    child: EmptyListWidget(
                      title: emptyListTitle,
                      subtitle: emptyListSubTitle,
                      callback: _importProductsFromJson,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.productList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: MarketProductWidget(
                          product: state.productList[index],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ErrorOnLoadingProductsState) {
                return Center(
                  child: ErrorMessageWidget(
                    title: errorMessageTitle,
                    subtitle: errorMessageSubtitle,
                  ),
                );
              } else {
                return LoadingProductList();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(position: 0),
    );
  }
}
