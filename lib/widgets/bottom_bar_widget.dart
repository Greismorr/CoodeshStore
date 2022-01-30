import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class BottomBarWidget extends StatefulWidget {
  final int position;

  BottomBarWidget({required this.position});

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 55,
        color: Colors.black12,
        child: InkWell(
          onTap: () =>
              Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.home_rounded,
                color: PRIMARY_COLOR,
                size: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
