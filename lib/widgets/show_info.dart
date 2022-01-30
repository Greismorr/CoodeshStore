import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

void showInfo(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: SECONDARY_COLOR,
    ),
  );
}
