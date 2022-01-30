import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import "package:coodesh_store/extensions/string_extension.dart";

class CategoryWidget extends StatelessWidget {
  final String? name;
  final bool isSelected;

  CategoryWidget({
    this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: SECONDARY_COLOR,
            )
          : BoxDecoration(
              color: PRIMARY_COLOR,
            ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Text(
        name?.capitalize() ?? '',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
