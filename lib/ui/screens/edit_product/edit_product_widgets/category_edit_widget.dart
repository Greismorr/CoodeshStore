import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/ui/screens/loading/loading_categories.dart';
import 'package:coodesh_store/widgets/category_widget.dart';
import 'package:coodesh_store/widgets/error_message_widget.dart';
import 'package:coodesh_store/widgets/new_category_dialog.dart';

class CategoryEditWidget extends StatefulWidget {
  final Product product;

  const CategoryEditWidget({
    required this.product,
  });

  @override
  _CategoryEditWidgetState createState() => _CategoryEditWidgetState();
}

class _CategoryEditWidgetState extends State<CategoryEditWidget> {
  final String fieldTitle = "Category";
  final errorMessageTitle = "Something's went wrong... 😥";
  final errorMessageSubtitle = "Try again another time.";
  final addNewCategoryLabel = " + ";
  late ProductBloc productBloc;

  _createNewCategoryDialog(List<String> dataList) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewCategoryDialog(
          categoryList: dataList,
          onSubmitted: createNewCategory,
        );
      },
    );
  }

  createNewCategory(NewCategoryDialogResponse category) {
    widget.product.type = category.newCategory;

    productBloc.add(
      SavingNewCategoryEvent(
          category: category.newCategory,
          categoriesList: category.categoriesList),
    );
  }

  @override
  Widget build(BuildContext context) {
    productBloc = BlocProvider.of<ProductBloc>(context);

    //Adiciona o evento LoadingProductsCategories ao bloc apenas se o estado
    //atual não for CategoriesOfProductLoadedState. Isso faz com que o setState
    //não faça resete a lista de categorias.
    if (!(productBloc.state is CategoriesOfProductLoadedState)) {
      productBloc.add(
        LoadingProductsCategoriesEvent(currentProductType: widget.product.type),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 5.0),
          child: Text(
            fieldTitle,
            style: TextStyle(
              fontSize: 18,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ErrorSavingChangesOnProductState ||
                state is NewCategoryErrorOnSavingState) {
              return Center(
                child: ErrorMessageWidget(
                  title: errorMessageTitle,
                  subtitle: errorMessageSubtitle,
                ),
              );
            } else if (state is CategoriesOfProductLoadedState) {
              List<String> dataList = state.categoriesList;

              return Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: dataList.length + 1,
                    itemBuilder: (context, index) {
                      return index < dataList.length
                          ? GestureDetector(
                              child: CategoryWidget(
                                name: dataList[index],
                                isSelected:
                                    dataList[index] == widget.product.type,
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    widget.product.type = dataList[index];
                                  },
                                );
                              },
                            )
                          : GestureDetector(
                              child: CategoryWidget(
                                name: addNewCategoryLabel,
                                isSelected: false,
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    _createNewCategoryDialog(dataList);
                                  },
                                );
                              },
                            );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              );
            } else {
              return LoadingCategories();
            }
          },
        ),
      ],
    );
  }
}
