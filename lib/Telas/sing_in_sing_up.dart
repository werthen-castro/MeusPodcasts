import 'package:flutter/material.dart';
import 'package:meuspodcast/Telas/cadastro.dart';
import 'package:meuspodcast/Telas/home.dart';
import 'package:meuspodcast/Telas/login.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/utis/Login_Google.dart';
import 'package:meuspodcast/widgets/ButtonApp.dart';

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
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Image.asset('assets/images/logo.png'),
                ),
                ButtonApp(
                  texto: 'Entrar com email',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _irLogin,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonApp(
                  texto: 'Criar conta',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _irCadastro,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonApp(
                  texto: 'Entrar com conta Google',
                  corBotao: Colors.white,
                  corBodas: Colors.white,
                  action: _loginGoogle,
                  corText: Colors.black,
                  tipoFonte: FontWeight.bold,
                  image: Image.asset(
                    'assets/images/google_logo.png',
                    height: 40,
                  ),
                ),
                SizedBox(
                  height: 40,
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
            return Home();
          },
        ),
      );
    });
  }

  _irLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Login()),
    );
  }

  _irCadastro() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Cadastro()),
    );
  }
}
