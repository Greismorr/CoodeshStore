import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';

class DescriptionEditWidget extends StatefulWidget {
  final Product product;

  const DescriptionEditWidget({
    required this.product,
  });

  @override
  _DescriptionEditWidgetState createState() => _DescriptionEditWidgetState();
}

class _DescriptionEditWidgetState extends State<DescriptionEditWidget> {
  final String fieldTitle = "Description";
  //final String descriptionLengthError = "Description can't be empty";
  final String descriptionHintText = "Type product's description";

  @override
  Widget build(BuildContext context) {
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
        SizedBox(
          width: 271,
          child: Material(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 16,
                top: 25,
                bottom: 15,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 94,
                    child: TextFormField(
                      validator: (val) {
                        //Descrição é um campo opcional
                        /*                         
                          if (val!.isEmpty || val.trim().isEmpty) {
                            return descriptionLengthError;
                          }
                        */

                        return null;
                      },
                      onChanged: (val) {
                        setState(() => widget.product.description = val);
                      },
                      minLines: 5,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 150,
                      initialValue: widget.product.description,
                      keyboardType: TextInputType.text,
                      decoration: textInputDecoration.copyWith(
                        hintMaxLines: 5,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        hintText: descriptionHintText,
                      ),
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
