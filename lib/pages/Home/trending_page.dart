import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meuspodcast/bloc/trending_bloc.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/models/podcast.dart';

import '../podcast_page.dart';
class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TrendingBloc _trendingBloc = TrendingBloc();
  ScrollController _scrollController = ScrollController();
  bool controller = true;

 @override
  void initState() {

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9 && controller){
        log('nova request');

         controller = false;

        Future.delayed(const Duration(milliseconds: 2000), () {
            controller = true;
        });
         _trendingBloc.getBestPodcasts();
      } 
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  RefreshIndicator(
      onRefresh: _trendingBloc.getBestPodcasts,
      child: StreamBuilder<List<Podcast>>(
              stream: _trendingBloc.podcasts,
              builder: (context, snapshot) {
                return Container(
                  color: AppColors.primaryColor,
                  child: snapshot.hasData
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.count(
                            controller: _scrollController,
                              crossAxisCount: 2,
                              children: List.generate(snapshot.data.length, (index) {
                                return Center(
                                  child: _card(snapshot.data[index] ),
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
            ),
    );
  }

  
  _card(Podcast podcast) {
    return GestureDetector(
      onTap: () {
        print('cliquei !!!');
        inspect(podcast);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PodcastPage(podcast)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: AppColors.primaryColor,
          child: Image.network(podcast.thumbnail),
        ),
      ),
    );
  }
}
