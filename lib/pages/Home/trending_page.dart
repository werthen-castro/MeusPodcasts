import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meuspodcast/bloc/trending_bloc.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/models/podcast.dart';

import '../../key.dart';
import '../podcast_page.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TrendingBloc _trendingBloc = TrendingBloc();

  _card(Podcast podcast) {
    return GestureDetector(
      onTap: () {
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

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
            stream: _trendingBloc.podcasts,
            builder: (context, snapshot) {
              return Container(
                color: AppColors.primaryColor,
                child: snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(snapshot?.data.length, (index) {
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
          );
  }
}
