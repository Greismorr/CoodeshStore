import 'package:coodesh_store/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coodesh_store/bloc/product/product_bloc.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';

Future<dynamic> buildBottomSheetDeleteOrEdit(
    BuildContext myContext, Product product) {
  final String editOption = "Edit";
  final String deleteOption = "Delete";
  final String deleteOptionConfirm = "Are you sure?";
  final String cancelOption = "Cancel";
  final String confirmOption = "Confirm";
  ProductBloc productBloc;
  productBloc = BlocProvider.of<ProductBloc>(myContext);

  return showModalBottomSheet(
    context: myContext,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.edit_outlined,
              color: PRIMARY_COLOR,
            ),
            title: Text(
              editOption,
              style: TextStyle(color: PRIMARY_COLOR),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, PRODUCT_EDIT, (route) => false,
                  arguments: product);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outlined,
              color: PRIMARY_COLOR,
            ),
            title: Text(
              deleteOption,
              style: TextStyle(color: PRIMARY_COLOR),
            ),
            onTap: () async {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    deleteOption,
                    style: TextStyle(color: PRIMARY_COLOR),
                  ),
                  content: Text(
                    deleteOptionConfirm,
                    style: TextStyle(color: PRIMARY_COLOR),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        cancelOption,
                        style: TextStyle(color: PRIMARY_COLOR),
                      ),
                    ),
                    TextButton(
                      child: Text(confirmOption),
                      onPressed: () {
                        Navigator.pop(context);
                        productBloc.add(DeletingProductEvent(product: product));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
