import 'dart:convert';
import 'dart:developer';

import 'package:meuspodcast/config.dart';
import 'package:meuspodcast/models/podcast.dart';
import 'package:meuspodcast/utis/api_connector.dart';
import 'package:rxdart/rxdart.dart';
class TrendingBloc{

  TrendingBloc(){
    getBestPodcasts();
  }

  ApiConnector _apiConnector = ApiConnector();
  List<Podcast> listPodcasts = [];
  static const limit = 0;

  final _podcasts = BehaviorSubject<List<Podcast>>();
  get podcasts => _podcasts.stream;

  final _offset = BehaviorSubject<int>.seeded(1);
  get offset => _offset.stream;

  Future<void> getBestPodcasts() async {
    var response = await _apiConnector.apiGet(
        "${urlBaseApi}best_podcasts?limit=$limit&page=${_offset.value}&$region", headers: headersListenApi
    );
    var data = json.decode(response.body.toString());


    for (int i = 0; i < data['podcasts'].length; i++) {
      listPodcasts.add(Podcast.map(data['podcasts'][i]));
    }

    _podcasts.add(listPodcasts);
    _offset.add(_offset.value + 1);
  }

  dispose(){
    _podcasts.close();
    _offset.close();
  }

}