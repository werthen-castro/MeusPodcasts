import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Telas/Home.dart';
import 'Telas/LoginLogout.dart';
import 'colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarBrightness: Brightness.light));

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser userLogado = await auth.currentUser();

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
    home: userLogado != null ? Home() : LoginLogout(),
  ));
}
