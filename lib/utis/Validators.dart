import 'dart:async';

class Validators {
  static final validateRegex = (RegExp regex, String errorMessage) =>
  StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (regex.hasMatch(data)) {
      sink.add(data);
    } else {
      sink.addError(errorMessage);
    }
  });

  static final validateMinLength = (int length, String errorMessage) =>
  StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length >= length) {
      sink.add(data);
    } else {
      sink.addError(errorMessage);
    }
  });

  static final validateEqualLength = (int length, String errorMessage) =>
  StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length == length) {
      sink.add(data);
    } else {
      sink.addError(errorMessage);
    }
  });



  final validateEmail = validateRegex(
      RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
      'Endereço de email inválido');

  final validateSenha = validateRegex(
      RegExp(r"^[0-9]{8}"),'Informe sua senha'
  );

  final validateCadastroSenha = validateRegex(
      RegExp(r"^[0-9]{8}"),'A senha deve ter apenas 8 números'
  );

  final validCPF = validateEqualLength(11,'Digite seu cpf');

  final validCodigo = validateEqualLength(6, 'Digite o codigo de verficação');



}