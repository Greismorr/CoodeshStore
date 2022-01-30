import 'package:flutter/material.dart';

showError(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
