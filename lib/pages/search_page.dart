import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/colors.dart';
import 'package:http/http.dart' as http;
import 'package:meuspodcast/models/podcast.dart';

import '../config.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search = '';
  int _offset = 0;
  List<Podcast> _podcasts = [];

  Future<void> search() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://listen-api.listennotes.com/api/v2/search?q=$_search'
            '&type=podcast&offset=$_offset&len_min=10&len_max=10&only_in=title&language=Portuguese'),
        headers: {"X-ListenAPI-Key": "$listenAPIKey"});

    var data = json.decode(response.body.toString());

    for (int i = 0; i < data['results'].length; i++) {
      _podcasts.add(Podcast.map(data['results'][i]));
    }

    setState(() {});
  }

  _card(titulo, imagem, description) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: AppColors.primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imagem,
              height: 110,
              width: 100,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
                  onTap: () {
                    search();
                  },
                  child: Icon(Icons.search, color: Colors.white, size: 30)),
            )
          ],
          title: Container(
            height: 35,
            child: Center(
              child: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                onChanged: (x) {
                  setState(() {
                    _search = x;
                  });
                },
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    hoverColor: Colors.white,
                    fillColor: AppColors.primary,
                    focusColor: Colors.white,
                    hintText: 'Pesquise aqui',
                    hintStyle: TextStyle(color: Colors.white)),
                onSubmitted: (x) {
                  search();
                },
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: _podcasts?.length,
          itemBuilder: (BuildContext context, int index) {
            return _card(_podcasts[index].title, _podcasts[index].thumbnail,
                _podcasts[index].description);
          },
        ));
  }
}
