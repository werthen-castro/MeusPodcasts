import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuspodcast/bloc/sing_up_bloc.dart';
import 'package:meuspodcast/colors.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  SingUpBloc _cadastroBloc = SingUpBloc();
  bool ob = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Criar Conta',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _logo(),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Email',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                _email(),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Senha',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                _senha(),
                SizedBox(
                  height: 20,
                ),
                _btnEntrar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/microfone.png',
            height: 150,
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Meus',
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.left,
              ),
              Text(
                'Podcasts',
                style: TextStyle(color: Colors.white, fontSize: 45),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _email() {
    return StreamBuilder(
      stream: _cadastroBloc.email,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                hoverColor: Colors.white,
                fillColor: Colors.white,
                errorText: snapshot.error,
              ),
              onChanged: _cadastroBloc.changeEmail,
            ),
            !snapshot.hasError
                ? SizedBox(
                    height: 22,
                  )
                : Container()
          ],
        );
      },
    );
  }

  Widget _senha() {
    return StreamBuilder(
      stream: _cadastroBloc.senha,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              obscureText: ob,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                errorText: snapshot.error,
                hoverColor: Colors.white,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    icon: ob
                        ? Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                    onPressed: () {
                      setState(() {
                        ob = !ob;
                      });
                    }),
              ),
              onChanged: _cadastroBloc.changeSenha,
            ),
            !snapshot.hasError
                ? SizedBox(
                    height: 22,
                  )
                : Container()
          ],
        );
      },
    );
  }

  Widget _btnEntrar() {
    return StreamBuilder(
        stream: _cadastroBloc.validCastro,
        builder: (context, snapshot) {
          return Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: snapshot.hasData
                  ? () async {
                      _cadastroBloc.cadastrarUsuario(context);
                    }
                  : null,
              child: Text(
                'Cadastrar',
                style: TextStyle(fontSize: 21),
              ),
            ),
          );
        });
  }
}
