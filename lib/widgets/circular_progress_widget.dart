import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class CircularProgressWidget extends StatelessWidget {
  final double? progress;
  final double? width;

  CircularProgressWidget({
    this.progress,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: progress ?? null,
      strokeWidth: width ?? 1.0,
      color: SECONDARY_COLOR,
    );
  }
}
