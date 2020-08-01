import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/key.dart';

class EmAlta extends StatefulWidget {
  @override
  _EmAltaState createState() => _EmAltaState();
}

class _EmAltaState extends State<EmAlta> {
  var data;

  List _listThumbnail = [];
  List _listTitle = [];
  List _listDescription = [];
  List _listIds = [];
  bool _progressBarActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializar();
  }

  Future<void> inicializar() async {
    var response = await http.get(
        // Uri.encodeFull("https://listen-api.listennotes.com/api/v2/best_podcasts"),
        Uri.encodeFull(
            "https://listen-api.listennotes.com/api/v2/best_podcasts?limit=10&languages=Portuguese&region=br"),
        //Uri.encodeFull("https://listen-api.listennotes.com/api/v2/genres"),
        //   Uri.encodeFull("https://listen-api.listennotes.com/api/v2/regions"),
        headers: {"X-ListenAPI-Key": "$listenAPIKey"});

    data = json.decode(response.body.toString());


    for (int i = 0; i < data['podcasts'].length; i++) {
      _listDescription.add(data['podcasts'][i]['description']);
      _listThumbnail.add(data['podcasts'][i]['thumbnail']);
      _listTitle.add(data['podcasts'][i]['title']);
      _listIds.add(data['podcasts'][i]['id']);
    }

      setState(() {
        _progressBarActive = true;
      });
  }

  _card(titulo, imagem) {
    return Card(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Image.network(imagem),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: _progressBarActive
          ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(_listThumbnail?.length, (index) {
                  return Center(
                    child: _card(_listTitle[index], _listThumbnail[index]),
                  );
                })),
          )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
