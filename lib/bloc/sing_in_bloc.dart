import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/Pages/Home/home_page.dart';
import 'package:meuspodcast/utis/Validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _email = BehaviorSubject<String>();
  get email => _email.stream.transform(validateEmail);
  get changeEmail => _email.add;

  final _senha = BehaviorSubject<String>();
  get senha => _senha.stream.transform(validateSenha);
  get changeSenha => _senha.add;

  get validLogin => Observable.combineLatest(
        <Stream>[email, senha],
        (values) => true,
      );

  dispose() {
    _email.close();
    _senha.close();
  }

  login(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: _email.value.trim(), password: _senha.value.trim())
        .then((firebaseUSer) {
      print("Login com sucesso");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }).catchError((error) {
      print("Erro ao logar: " + error.toString());
    });
  }
}
