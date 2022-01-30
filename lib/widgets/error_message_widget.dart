import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  ErrorMessageWidget({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 65,
          height: 65,
          child: Stack(
            children: [
              SizedBox(
                width: 65,
                height: 65,
                child: Material(
                  color: SECONDARY_COLOR,
                  shape: CircleBorder(),
                ),
              ),
              Positioned.fill(
                child: Icon(
                  Icons.error_outline_rounded,
                  color: TEXT_BUTTON_COLOR,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          width: 250,
          height: 61,
          child: Text(
            this.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 355,
          height: 56,
          child: Text(
            this.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
