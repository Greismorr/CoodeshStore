import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class RatingWidget extends StatefulWidget {
  final int rating;
  final double size;
  final Function(int)? updateRatingCallback;

  RatingWidget(
      {required this.rating, required this.size, this.updateRatingCallback});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int currentRating = 0;

  @override
  void initState() {
    currentRating = widget.rating;
    super.initState();
  }

  List<Widget> _buildRating() {
    List<Widget> stars = [];

    //Preenche as estrelas coloridas de acordo com a avaliação do produto
    for (int count = 0; count < currentRating; count++) {
      stars.add(
        GestureDetector(
          child: Icon(
            Icons.star,
            size: widget.size,
            color: SECONDARY_COLOR,
          ),
          onTap: () {
            if (widget.updateRatingCallback != null) {
              setState(() {
                currentRating = count + 1;
                widget.updateRatingCallback!(currentRating);
              });
            }
          },
        ),
      );
    }

    //Preenche o resto das estrelas com a cor cinza, caso necessário
    for (int count = stars.length; count < 5; count++) {
      stars.add(
        GestureDetector(
          child: Icon(
            Icons.star,
            size: widget.size,
            color: UNCHECKED_STAR_COLOR,
          ),
          onTap: () {
            if (widget.updateRatingCallback != null) {
              setState(() {
                currentRating = count + 1;
                widget.updateRatingCallback!(currentRating);
              });
            }
          },
        ),
      );
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRating(),
    );
  }
}
