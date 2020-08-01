import 'package:flutter/material.dart';
import 'package:meuspodcast/colors.dart';

class ButtonApp extends StatelessWidget {
  final String texto;
  final Color corBotao;
  final Color corBodas;
  final double arrendondamento;
  final double largura;
  final double altura;
  final Function action;
  final Color corText;
  final FontWeight tipoFonte;
  final Image image;
  bool ativo;

  ButtonApp({
    @required this.texto,
    @required this.corBotao,
    @required this.corBodas,
    @required this.action,
    @required this.corText,
    this.tipoFonte = FontWeight.normal,
    this.arrendondamento = 5.0,
    this.largura,
    this.altura = 60,
    this.image,
    this.ativo = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: action ,
          child: Container(
            decoration: BoxDecoration(
              color:  corBotao ,
              border: Border.all( color: corBodas),
              borderRadius: BorderRadius.all(Radius.circular(arrendondamento)),
            ),
            height: altura,
            width:  largura == null ? MediaQuery.of(context).size.width : largura,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image == null ?  Container() : Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: image,
                ),
                Center(child: Text(texto, style: TextStyle(color: corText, fontSize: 20, fontWeight: tipoFonte),)),
              ],
            ),
          ),
        );
  }
}
