import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:coodesh_store/constants/repository_response.dart';
import 'package:coodesh_store/models/interfaces/product_repository_interface.dart';
import 'package:coodesh_store/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _repository;

  ProductBloc({
    required IProductRepository productsRepository,
  })  : this._repository = productsRepository,
        super(ProductsLoadingInitial());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductsLoadingEvent) {
      yield* _mapProductsLoadingToState(event);
    } else if (event is ImportingProductsFromJsonEvent) {
      yield* _mapImportingProductsFromJsonToState(event);
    } else if (event is LoadingProductsCategoriesEvent) {
      yield* _mapLoadingProductsCategoriesToState(event);
    } else if (event is SavingChangesOnProductEvent) {
      yield* _mapSavingChangesOnProduct(event);
    } else if (event is DeletingProductEvent) {
      yield* _mapDeletingProductEvent(event);
    } else if (event is SavingNewCategoryEvent) {
      yield* _mapSavingNewCategoryEvent(event);
    }
  }

  Stream<ProductState> _mapProductsLoadingToState(
      ProductsLoadingEvent event) async* {
    yield ProductsLoadingState();

    try {
      List<Product> productList = await _repository.getAllProducts();
      yield ProductsLoadedState(productList: productList);
    } catch (e) {
      print(e);
      yield ErrorOnLoadingProductsState();
    }
  }

  Stream<ProductState> _mapImportingProductsFromJsonToState(
      ImportingProductsFromJsonEvent event) async* {
    yield ImportingProductsFromJsonState();

    if (await _repository.loadProductsIntoDatabase(event.data) == SUCCESS) {
      yield SuccessOnImportingProductsState();
      List<Product> productList = await _repository.getAllProducts();
      yield ProductsLoadedState(productList: productList);
    } else {
      yield ErrorOnLoadingProductsState();
    }
  }

  Stream<ProductState> _mapLoadingProductsCategoriesToState(
      LoadingProductsCategoriesEvent event) async* {
    yield LoadingProductsCategoriesState();

    List<String> categoriesList = await _repository.getAllCategories();

    if (categoriesList.isNotEmpty) {
      if (event.currentProductType != null) {
        //Faz com que a categoria do produto seja sempre
        //a primeira da lista.
        categoriesList.remove(event.currentProductType);
        categoriesList.insert(0, event.currentProductType as String);
      }

      yield CategoriesOfProductLoadedState(categoriesList: categoriesList);
    } else {
      yield ErrorOnLoadingProductsState();
    }
  }

  Stream<ProductState> _mapSavingChangesOnProduct(
      SavingChangesOnProductEvent event) async* {
    yield SavingChangesOnProductState();

    if (await _repository.saveProduct(event.product, event.pictureHasChanged) ==
        SUCCESS) {
      yield ChangesOnProductSavedState();
    } else {
      yield ErrorSavingChangesOnProductState();
    }
  }

  Stream<ProductState> _mapDeletingProductEvent(
      DeletingProductEvent event) async* {
    yield ProductBeingDeletedState();

    if (await _repository.deleteProduct(event.product) == SUCCESS) {
      yield ProductDeletedState();
      yield ProductsLoadingState();
    } else {
      yield ErrorDeletingProductState();
    }
  }

  Stream<ProductState> _mapSavingNewCategoryEvent(
      SavingNewCategoryEvent event) async* {
    yield SavingNewCategoryState();

    if (await _repository.saveCategory(event.category, event.categoriesList) ==
        SUCCESS) {
      yield NewCategorySavedState();
      yield CategoriesOfProductLoadedState(
          categoriesList: event.categoriesList);
    } else {
      yield NewCategoryErrorOnSavingState();
    }
  }
}
