import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/Pages/Home/home_page.dart';
import 'package:meuspodcast/utis/Validators.dart';
import 'package:rxdart/rxdart.dart';

class SingUpBloc with Validators {

  final _email = BehaviorSubject<String>();
  get email => _email.stream.transform(validateEmail);
  get changeEmail => _email.add;

  final _senha = BehaviorSubject<String>();
  get senha => _senha.stream.transform(validateCadastroSenha);
  get changeSenha => _senha.add;

  get validCastro => Observable.combineLatest(
    <Stream>[email, senha],
        (values) => true,
  );

  dispose(){
    _senha.close();
    _email.close();
  }

  cadastrarUsuario(context) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
        email: _email.value.trim(), password: _senha.value.trim())
        .then((firebaseUser) {
      print("Sucesso ao criar usuario");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }).catchError((error) {
      print("Erro ao criar usuario");
    });
  }










}
