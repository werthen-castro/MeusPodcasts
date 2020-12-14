import 'dart:convert';

import 'package:meuspodcast/config.dart';
import 'package:meuspodcast/models/podcast.dart';
import 'package:meuspodcast/utis/api_connector.dart';
import 'package:rxdart/rxdart.dart';
class PodcastBloc{

  ApiConnector _apiConnector = ApiConnector();

  final _podcast = BehaviorSubject<Podcast>();
  get podcast => _podcast.stream;

  Future<void> getPodcast(String id) async {
    var response = await _apiConnector.apiGet(
        "${urlBaseApi}podcasts/$id", headers: headersListenApi
    );

    print(id);
    print(response);
    var data = json.decode(response.body.toString());

    _podcast.add(Podcast.map(data));
  }

  dispose(){
    _podcast.close();
  }

}