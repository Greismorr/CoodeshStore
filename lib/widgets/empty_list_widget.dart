import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(BuildContext)? callback;

  EmptyListWidget({required this.title, required this.subtitle, this.callback});

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
                child: IconButton(
                  icon: Icon(Icons.add_shopping_cart_rounded),
                  color: TEXT_BUTTON_COLOR,
                  onPressed: () async {
                    if (callback != null) {
                      await callback!(context);
                    }
                  },
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
