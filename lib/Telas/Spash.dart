import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuspodcast/Telas/Home.dart';
import 'package:meuspodcast/Telas/Login.dart';
import 'package:meuspodcast/Telas/LoginLogout.dart';
import 'package:meuspodcast/colors.dart';

class Spash extends StatefulWidget {
  @override
  _SpashState createState() => _SpashState();
}

class _SpashState extends State<Spash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
    ));
    verificaLoginFirebase();
  }

  verificaLoginFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogado = await auth.currentUser();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if(userLogado != null){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => Home()),
        );
      }else{
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => LoginLogout()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        height: MediaQuery.of(context).size.height,
        child: Image.asset('assets/imagens/logo.png'),
      ),
    );
  }


}
