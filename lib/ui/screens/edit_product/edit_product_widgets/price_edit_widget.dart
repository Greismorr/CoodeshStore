import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';

class PriceEditWidget extends StatefulWidget {
  final Product product;

  const PriceEditWidget({
    required this.product,
  });

  @override
  _PriceEditWidgetState createState() => _PriceEditWidgetState();
}

class _PriceEditWidgetState extends State<PriceEditWidget> {
  final String fieldTitle = "Price";
  final String priceLengthError = "Type product's price";
  final String priceNegativeError = "Product's price can't be negative";
  final String priceFormatError = "Product's price can't be negative";
  final String priceHintText = "Product's price";

  //Valida o campo preço como um double
  final String regExPattern = r'^\d{0,8}(\.\d{1,4})?$';

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
            if (val!.trim().isNotEmpty) {
              RegExp regExp = new RegExp(regExPattern);

              if (regExp.hasMatch(val)) {
                if (double.parse(val) < 0) {
                  return priceNegativeError;
                }
                return null;
              }
              return priceFormatError;
            }

            return priceLengthError;
          },
          onChanged: (val) {
            setState(
              () {
                if (val.trim().isNotEmpty) {
                  RegExp regExp = new RegExp(regExPattern);

                  if (regExp.hasMatch(val)) {
                    if (double.parse(val) > 0) {
                      widget.product.price = double.parse(val);
                    }
                  }
                }
              },
            );
          },
          keyboardType: TextInputType.number,
          initialValue: widget.product.price.toStringAsFixed(2),
          textCapitalization: TextCapitalization.sentences,
          maxLength: 50,
          decoration: textInputDecoration.copyWith(
            hintText: priceHintText,
            hintStyle: TextStyle(fontSize: 16),
            counterText: "",
            prefixIcon: Icon(
              Icons.attach_money_rounded,
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
