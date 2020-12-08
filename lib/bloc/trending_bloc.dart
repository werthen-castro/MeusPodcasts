import 'dart:convert';

import 'package:meuspodcast/key.dart';
import 'package:meuspodcast/models/podcast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class TrendingBloc{

  TrendingBloc(){
    getBestPodcasts();
  }

  final _podcasts = BehaviorSubject<List<Podcast>>();
  get podcasts => _podcasts.stream;

  final _offset = BehaviorSubject<int>.seeded(1);
  get offset => _offset.stream;

  List<Podcast> listPodcasts = [];

  Future<void> getBestPodcasts() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://listen-api.listennotes.com/api/v2/best_podcasts?limit=10&languages=Portuguese&region=br"),
        headers: {"X-ListenAPI-Key": "$listenAPIKey"});

    var data = json.decode(response.body.toString());

    for (int i = 0; i < data['podcasts'].length; i++) {
      listPodcasts.add(Podcast.map(data['podcasts'][i]));
    }

    _podcasts.add(listPodcasts);
  }

  dispose(){
    _podcasts.close();
    _offset.close();
  }

}