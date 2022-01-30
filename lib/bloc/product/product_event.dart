part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductsLoadingEvent extends ProductEvent {
  ProductsLoadingEvent();

  @override
  List<Object> get props => [];
}

class ImportingProductsFromJsonEvent extends ProductEvent {
  final String data;

  ImportingProductsFromJsonEvent({required this.data});

  @override
  List<Object> get props => [];
}

class LoadingProductsCategoriesEvent extends ProductEvent {
  final String? currentProductType;

  LoadingProductsCategoriesEvent({this.currentProductType});

  @override
  List<Object> get props => [];
}

class SavingChangesOnProductEvent extends ProductEvent {
  final Product product;
  final bool pictureHasChanged;

  SavingChangesOnProductEvent({required this.product, required this.pictureHasChanged});

  @override
  List<Object> get props => [];
}

class DeletingProductEvent extends ProductEvent {
  final Product product;

  DeletingProductEvent({required this.product});

  @override
  List<Object> get props => [];
}

class SavingNewCategoryEvent extends ProductEvent {
  final String category;
  final List<String> categoriesList;

  SavingNewCategoryEvent(
      {required this.category, required this.categoriesList});

  @override
  List<Object> get props => [];
}
