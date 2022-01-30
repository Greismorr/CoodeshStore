import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Color(0xFF4b5c6b);
const Color SECONDARY_COLOR = Color(0xFF6558f5);
const Color PLACEHOLDER_COLOR = Color(0xFF4b5c6b);
const Color BORDER_COLOR = Color(0xFFc3cfd9);
const Color UNCHECKED_STAR_COLOR = Color(0xFFc3ccd4);
const Color TEXT_BUTTON_COLOR = Color(0xFFFFFFFF);
const String PLACEHOLDER_IMAGE =
    "https://res.cloudinary.com/dtlmxp4oo/image/upload/v1642542488/SM-placeholder_t7nuqk.png";

const InputDecoration textInputDecoration = InputDecoration(
  labelStyle: TextStyle(
      color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 20),
);

final BoxDecoration boxDecoration = BoxDecoration(
  color: PRIMARY_COLOR,
  borderRadius: BorderRadius.circular(5),
);
