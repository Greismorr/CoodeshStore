import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class CategoryLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: SizedBox(
        width: 50,
        height: 30,
      ),
    );
  }
}
