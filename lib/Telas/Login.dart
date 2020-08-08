import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuspodcast/bloc/login_bloc.dart';
import 'package:meuspodcast/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc = LoginBloc();
  bool ob = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: new IconThemeData(color: Colors.white),
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
                        style: TextStyle(color: Colors.white, fontSize: 19),
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
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ],
                ),
                _senha(),
                _linkEsqueceuSenha(),
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
      padding: const EdgeInsets.only(bottom: 45, top: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            height: 200,
          ),
        ],
      ),
    );
  }

  Widget _linkEsqueceuSenha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: InkWell(
            child: Text(
              "Esqueceu a senha ?",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            onTap: () {
              print('ir esqueceu a senha !');
            },
          ),
        ),
      ],
    );
  }

  Widget _email() {
    return StreamBuilder(
      stream: _loginBloc.email,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  errorText: snapshot.error,
                ),
                onChanged: _loginBloc.changeEmail,
              ),
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
      stream: _loginBloc.senha,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: ob,
                decoration: InputDecoration(
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
                onChanged: _loginBloc.changeSenha,
              ),
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
        stream: _loginBloc.validLogin,
        builder: (context, snapshot) {
          return Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: snapshot.hasData
                  ? () async {
                      _loginBloc.login(context);
                    }
                  : null,
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 21),
              ),
            ),
          );
        });
  }
}
