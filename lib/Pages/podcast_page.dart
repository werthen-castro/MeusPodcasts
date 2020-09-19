import 'package:flutter/material.dart';
import 'package:meuspodcast/models/podcast.dart';

class PodcastPage extends StatefulWidget {
  final Podcast podcast;

  PodcastPage(this.podcast);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.podcast.title, style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
