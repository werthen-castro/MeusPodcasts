import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/colors.dart';
import 'package:http/http.dart' as http;
import 'package:meuspodcast/key.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var data;
  List _listThumbnail = [];
  List _listTitle = [];
  List _listDescription = [];
  List _listIds = [];
  bool _progressBarActive = false;
  String texto = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<void> inicializar() async {
    var response = await http.get(
      // Uri.encodeFull("https://listen-api.listennotes.com/api/v2/best_podcasts"),
        Uri.encodeFull(
          'https://listen-api.listennotes.com/api/v2/search?q=casa&sort_by_date=0&type=podcast&offset=0&len_min=10&len_max=30&genre_ids=68%2C82&published_before=1580172454000&published_after=0&only_in=title&language=Portuguese&safe_mode=0'
//            "https://listen-api.listennotes.com/api/v2/search?q=$texto&languages=Portuguese&region=br"),
        //Uri.encodeFull("https://listen-api.listennotes.com/api/v2/genres"),
        //   Uri.encodeFull("https://listen-api.listennotes.com/api/v2/regions"),
        ),
        headers: {"X-ListenAPI-Key": "$listenAPIKey"});

    data = json.decode(response.body.toString());

    print('data: ' + data.toString());

    for (int i = 0; i < data['results'].length; i++) {
      _listThumbnail.add(data['results'][i]['thumbnail']);
      _listTitle.add(data['results'][i]['title_original']);
      _listIds.add(data['results'][i]['id']);
    }

    setState(() {
      _progressBarActive = true;
    });
  }

  _card(titulo, imagem) {
    return Card(
      color: AppColors.primaryColor,
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imagem, height: 150,),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Flexible(child: Text(titulo, style: TextStyle(color: Colors.white, fontSize: 15),)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: (){
                  inicializar();
                },
                child: Icon(Icons.search, color: Colors.white, size: 30)
            ),
          )
        ],
        title:  Container(
          height: 35,
          child: Center(
            child: TextField(
              onChanged: (x){
                setState(() {
                  texto = x;
                });
              },
              cursorColor: Colors.white,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  hoverColor: Colors.white,
                  fillColor: AppColors.primary,
                  focusColor: Colors.black
              ),
              onSubmitted: (x){
                inicializar();
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _listTitle?.length,
        itemBuilder: (BuildContext context, int index) {
          return  _card(_listTitle[index], _listThumbnail[index]);
        },
      )
    );
  }
}
