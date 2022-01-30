import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/category_edit_widget.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/description_edit_widget.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/picture_edit_widget.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/price_edit_widget.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/rating_edit_widget.dart';
import 'package:coodesh_store/ui/screens/edit_product/edit_product_widgets/title_edit_widget.dart';
import 'package:coodesh_store/widgets/app_bar_widget.dart';
import 'package:coodesh_store/widgets/circular_progress_widget.dart';
import 'package:coodesh_store/widgets/show_info.dart';
import 'package:uiblock/uiblock.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct({required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  bool pictureHasChanged = false;
  final String savingChanges =
      "We're trying to save your changes. Wait a second... 😉";
  final String changesSaved = "Changes saved successfully!";
  late ProductBloc productBloc;

  pictureHasChangedCallback() {
    pictureHasChanged = true;
  }

  @override
  Widget build(BuildContext context) {
    productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(hasPreviousScreen: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              BlocListener<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is SavingChangesOnProductState) {
                    UIBlock.block(
                      context,
                      safeAreaTop: false,
                      customLoaderChild: CircularProgressWidget(
                        width: 5.0,
                      ),
                    );
                    showInfo(savingChanges, context);
                  } else if (state is ChangesOnProductSavedState) {
                    //Esconde a snackbar atual para que a mostrada na tela
                    //seja sempre a mais recente.
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    UIBlock.unblock(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                    showInfo(changesSaved, context);
                  } else if (state is SavingNewCategoryState) {
                    showInfo(savingChanges, context);
                    UIBlock.block(
                      context,
                      safeAreaTop: false,
                      customLoaderChild: CircularProgressWidget(
                        width: 5.0,
                      ),
                    );
                  } else if (state is NewCategorySavedState) {
                    //Esconde a snackbar atual para que a mostrada na tela
                    //seja sempre a mais recente.
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    UIBlock.unblock(context);
                    showInfo(changesSaved, context);
                    productBloc.add(
                      LoadingProductsCategoriesEvent(
                          currentProductType: widget.product.type),
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          PictureEditWidget(
                            product: widget.product,
                            pictureHasChangedCallback:
                                pictureHasChangedCallback,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TitleEditWidget(
                            product: widget.product,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DescriptionEditWidget(
                            product: widget.product,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          PriceEditWidget(
                            product: widget.product,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RatingEditWidget(
                            product: widget.product,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CategoryEditWidget(
                            product: widget.product,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: SECONDARY_COLOR,
                                onPrimary: PRIMARY_COLOR,
                                padding: EdgeInsets.all(5),
                                elevation: 6,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  productBloc.add(
                                    SavingChangesOnProductEvent(
                                        product: widget.product,
                                        pictureHasChanged: pictureHasChanged),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
