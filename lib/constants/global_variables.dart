import 'package:flutter/material.dart';

String uri = 'https://api.dijun.cc:4577';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const backgroundColor = Color.fromRGBO(217, 220, 214, 1);
  static const primarycolor = Color.fromRGBO(7, 127, 131, 1);
  static const secondaryColor = Color.fromRGBO(127, 183, 190, 1);
  static const TextWhiteColor = Color.fromRGBO(246, 246, 246, 1);
  static const TextBlackColor = Color.fromRGBO(0, 0, 0, 1);
  static const Selected = Color.fromRGBO(224, 156, 8, 1);
}
