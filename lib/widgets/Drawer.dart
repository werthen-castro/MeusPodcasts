import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/Telas/Login.dart';
import 'package:meuspodcast/Telas/LoginLogout.dart';
import 'package:meuspodcast/colors.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: AppColors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 228,
                color: AppColors.primaryColor,
                child: _logo(),
              ),
              Container(
                height: 70,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Color.fromRGBO(128, 128, 128, 1),
                      height: 2,
                    ),
                    Container(
                        height: 62,
                        color: AppColors.primaryColor,
                        child: GestureDetector(
                          onTap: () async {
                            _logout(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Icon(Icons.exit_to_app, color: Colors.white,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 17),
                                    child: Text(
                                      'Sair',
                                      style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

  Widget _logo(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 45, top: 80 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/imagens/microfone.png', height: 100, color: Colors.white,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Meus', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left,),
              Text('Podcasts', style: TextStyle(color: Colors.white, fontSize: 35),),
            ],
          )
        ],
      ),
    );
  }

  _logout(context){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginLogout()),
    );
  }


}


