import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
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
  final bool ativo;

  CustomButton(
      {@required this.texto,
      @required this.corBotao,
      @required this.corBodas,
      @required this.action,
      @required this.corText,
      this.tipoFonte = FontWeight.normal,
      this.arrendondamento = 5.0,
      this.largura,
      this.altura = 55,
      this.image,
      this.ativo = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          color: corBotao,
          border: Border.all(color: corBodas),
          borderRadius: BorderRadius.all(Radius.circular(arrendondamento)),
        ),
        height: altura,
        width: largura == null ? MediaQuery.of(context).size.width : largura,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: image,
                      ),
                Text(
                  texto,
                  style: TextStyle(
                      color: corText, fontSize: 18, fontWeight: tipoFonte),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
