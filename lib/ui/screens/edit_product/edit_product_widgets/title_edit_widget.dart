import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';

class TitleEditWidget extends StatefulWidget {
  final Product product;

  const TitleEditWidget({
    required this.product,
  });

  @override
  _TitleEditWidgetState createState() => _TitleEditWidgetState();
}

class _TitleEditWidgetState extends State<TitleEditWidget> {
  final String fieldTitle = "Title";
  final String titleLengthError = "Type product's name";
  final String titleHintText = "Product's name";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            fieldTitle,
            style: TextStyle(
              fontSize: 18,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
        TextFormField(
          validator: (val) {
            if (val!.isEmpty || val.trim().isEmpty) {
              return titleLengthError;
            }

            return null;
          },
          onChanged: (val) {
            setState(() => widget.product.title = val);
          },
          keyboardType: TextInputType.name,
          initialValue: widget.product.title,
          textCapitalization: TextCapitalization.sentences,
          maxLength: 50,
          decoration: textInputDecoration.copyWith(
            hintText: titleHintText,
            hintStyle: TextStyle(fontSize: 16),
            counterText: "",
            prefixIcon: Icon(
              Icons.title,
              color: PRIMARY_COLOR,
            ),
          ),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
