import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/widgets/rating_widget.dart';

class RatingEditWidget extends StatefulWidget {
  final Product product;

  const RatingEditWidget({
    required this.product,
  });

  @override
  _RatingEditWidgetState createState() => _RatingEditWidgetState();
}

class _RatingEditWidgetState extends State<RatingEditWidget> {
  final String fieldTitle = "Rating";

  updateRatingDialogCallback(int rating) {
    widget.product.rating = rating;
  }

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
        RatingWidget(
          rating: widget.product.rating,
          size: 36,
          updateRatingCallback: updateRatingDialogCallback,
        ),
      ],
    );
  }
}
