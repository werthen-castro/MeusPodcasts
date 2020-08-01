import 'package:flutter/material.dart';
import 'package:meuspodcast/Telas/Login.dart';
import 'package:meuspodcast/Telas/Spash.dart';

import 'colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
      primaryColor: Colors.white,
      accentColor: Colors.grey,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textTheme: ButtonTextTheme.normal),
    ),
    home: Spash(),
  ));
}
