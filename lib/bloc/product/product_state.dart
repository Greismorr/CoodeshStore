part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsLoadingInitial extends ProductState {
  ProductsLoadingInitial();
}

class ProductsLoadingState extends ProductState {
  ProductsLoadingState();
}

class ImportingProductsFromJsonState extends ProductState {
  ImportingProductsFromJsonState();
}

class ProductsLoadedState extends ProductState {
  final List<Product> productList;

  ProductsLoadedState({required this.productList});
}

class ErrorOnLoadingProductsState extends ProductState {
  ErrorOnLoadingProductsState();
}

class SuccessOnImportingProductsState extends ProductState {
  SuccessOnImportingProductsState();
}

class LoadingProductsCategoriesState extends ProductState {
  LoadingProductsCategoriesState();
}

class CategoriesOfProductLoadedState extends ProductState {
  final List<String> categoriesList;

  CategoriesOfProductLoadedState({required this.categoriesList});
}

class SavingChangesOnProductState extends ProductState {
  SavingChangesOnProductState();
}

class ChangesOnProductSavedState extends ProductState {
  ChangesOnProductSavedState();
}

class ProductDeletedState extends ProductState {
  ProductDeletedState();
}

class ErrorSavingChangesOnProductState extends ProductState {
  ErrorSavingChangesOnProductState();
}

class ProductBeingDeletedState extends ProductState {
  ProductBeingDeletedState();
}

class ErrorDeletingProductState extends ProductState {
  ErrorDeletingProductState();
}

class SavingNewCategoryState extends ProductState {
  SavingNewCategoryState();
}

class NewCategorySavedState extends ProductState {
  NewCategorySavedState();
}

class NewCategoryErrorOnSavingState extends ProductState {
  NewCategoryErrorOnSavingState();
}
