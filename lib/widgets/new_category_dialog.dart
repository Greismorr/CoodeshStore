import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class NewCategoryDialog extends StatefulWidget {
  final List<String> categoryList;
  final Function(NewCategoryDialogResponse) onSubmitted;

  const NewCategoryDialog({
    required this.categoryList,
    required this.onSubmitted,
  });

  @override
  _NewCategoryDialogState createState() => _NewCategoryDialogState();
}

class _NewCategoryDialogState extends State<NewCategoryDialog> {
  final _categoryController = TextEditingController();
  final String lengthError = "This field must have at least 4 characters.";
  final String alreadyExistsError = "This category already exists.";
  final String title = "Add a New Category";
  final String categoryHint = "Type the category name.";
  final String buttonText = "Save";
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _content = Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Form(
          key: _formKey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _categoryController,
                    textAlign: TextAlign.center,
                    validator: (val) {
                      if (val!.trim().length < 4) {
                        return lengthError;
                      } else if (widget.categoryList
                          .contains(val.toLowerCase())) {
                        return alreadyExistsError;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: categoryHint,
                      errorStyle: TextStyle(fontSize: 11),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.categoryList
                              .add(_categoryController.text.toLowerCase());

                          final _response = NewCategoryDialogResponse(
                            newCategory: _categoryController.text.toLowerCase(),
                            categoriesList: widget.categoryList,
                          );

                          widget.onSubmitted(_response);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: _content,
    );
  }
}

class NewCategoryDialogResponse {
  final String newCategory;
  final List<String> categoriesList;

  NewCategoryDialogResponse(
      {required this.newCategory, required this.categoriesList});
}
