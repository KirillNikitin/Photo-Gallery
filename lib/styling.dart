import 'package:flutter/material.dart';

// Colors
class AppColors {
  static Color white = Colors.white;
  static Color deepPurple = Colors.deepPurple;

  static Color fontLight = const Color.fromRGBO(250, 250, 250, .95);
}

// Text Styles
TextStyle mediumTextStyle = TextStyle(
    fontSize: 24, fontWeight: FontWeight.normal, color: AppColors.fontLight);
TextStyle smallTextStyle = TextStyle(
    fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.fontLight);

// Margins, Paddings, Border parameters
// Paddings based on The Fibonacci sequence 1, 2, 3, 5, 8, 13, 21, 34, 55,
const double xxsPadding = 1;
const double xsPadding = 3;
const double sPadding = 5;
const double mPadding = 8;
const double lPadding = 21;
const double xlPadding = 34;
const double xxlPadding = 55;

const double borderRadiusSmall = 5.0;
