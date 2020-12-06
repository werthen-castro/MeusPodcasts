import 'package:flutter/material.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/widgets/drawer.dart';

import 'downloads_page.dart';
import 'trending_page.dart';
import 'your_library_page.dart';
import 'podcasts_page.dart';
import '../search_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> _abas = <Widget>[
    PodcastsPage(),
    YourLibrary(),
    DownloadsPage(),
    TrendingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      drawer: DrawerApp(),
      appBar: AppBar(
      iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        title: Text('Meus Podcasts', style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SearchPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.search,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.share,),
          ),

        ],
      ),
      body: _abas[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home ),
            title: Text('Poscasts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text('Playlist',),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download, ),
            title: Text('Baixados'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up, ),
            title: Text('Em alta'),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
