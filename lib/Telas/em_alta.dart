import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/models/podcast.dart';

import '../keys.dart';

class EmAlta extends StatefulWidget {
  @override
  _EmAltaState createState() => _EmAltaState();
}

class _EmAltaState extends State<EmAlta> {

  List<Podcast> _podcasts = [];
  var data;

  @override
  void initState() {
    data = getData();
    super.initState();
  }

  Future<void> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://listen-api.listennotes.com/api/v2/best_podcasts?limit=10&languages=Portuguese&region=br"),
        headers: {"X-ListenAPI-Key": "$listenAPIKey"});

    var data = json.decode(response.body.toString());

    for (int i = 0; i < data['podcasts'].length; i++) {
      _podcasts.add(Podcast.map(data['podcasts'][i]));
    }
  }

  _card(imagem) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: AppColors.primaryColor,
        child: Image.network(imagem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future:  data,
      builder: (context, snapshot) {
        return Container(
          color: AppColors.primaryColor,
          child: snapshot.connectionState == ConnectionState.done
              ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(_podcasts?.length, (index) {
                      return Center(
                        child: _card( _podcasts[index].thumbnail),
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
    );
  }
}