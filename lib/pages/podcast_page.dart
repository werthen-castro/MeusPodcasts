import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meuspodcast/bloc/podcast_bloc.dart';
import 'package:meuspodcast/models/podcast.dart';
import 'package:meuspodcast/pages/player_page.dart';
import 'package:meuspodcast/widgets/custom_button.dart';

import '../colors.dart';

class PodcastPage extends StatefulWidget {
  final Podcast podcast;

  PodcastPage(this.podcast);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  PodcastBloc _podcastBloc = PodcastBloc();

  @override
  void initState() {
    _podcastBloc.getPodcast(widget.podcast.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  _body() {
    return StreamBuilder<Podcast>(
        stream: _podcastBloc.podcast,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Column(children: [
                    _header(snapshot),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.episodes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _card(snapshot, index);
                          }),
                    )
                  ]),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }

  _appBar() {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'teste',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _header(snapshot) {
    return Column(children: [
      Row(
        children: [
          Center(
              child: Image.network(
            snapshot.data.thumbnail ?? '',
            width: 180,
          )),
          Column(
            children: [
              CustomButton(
                largura: 100,
                texto: 'Seguir',
                corBotao: Colors.white,
                corBodas: Colors.white,
                corText: Colors.black,
                action: () {},
              ),
              Text(
                'Episódios: ' + snapshot.data.total_episodes.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          snapshot.data.description ?? '',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ]);
  }

  _card(snapshot, index) {
    return GestureDetector(
      onTap: (){
         Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SimpleRecorder()),
      );
      },
          child: Card(
        color: AppColors.primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              snapshot.data.episodes[index]['image'],
              height: 120,
              width: 120,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.episodes[index]['title'],
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
                        snapshot.data.episodes[index]['description'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
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
}
