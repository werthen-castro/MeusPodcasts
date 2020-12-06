import 'package:flutter/material.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/utis/Login_Google.dart';
import 'package:meuspodcast/widgets/custom_button.dart';

import 'sing_up_page.dart';
import 'Home/home_page.dart';
import 'sing_in_page.dart';

class SingInSingUp extends StatefulWidget {
  @override
  _SingInSingUpState createState() => _SingInSingUpState();
}

class _SingInSingUpState extends State<SingInSingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 60, top: 20),
                  child: Image.asset('assets/images/logo.png'),
                ),
                CustomButton(
                  texto: 'Entrar com email',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _irLogin,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  texto: 'Criar conta',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _irCadastro,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  texto: 'Entrar com conta Google',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _loginGoogle,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                  image: Image.asset(
                    'assets/images/google_logo.png',
                    height: 30,
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Text(
                  'Termos de uso',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginGoogle() {
    signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    });
  }

  _irLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SingInPage()),
    );
  }

  _irCadastro() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SingUpPage()),
    );
  }
}
