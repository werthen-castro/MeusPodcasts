import 'package:flutter/material.dart';
import 'package:meuspodcast/Telas/Baixados.dart';
import 'package:meuspodcast/Telas/EmAlta.dart';
import 'package:meuspodcast/Telas/Playlist.dart';
import 'package:meuspodcast/Telas/Podcasts.dart';
import 'package:meuspodcast/Telas/Search.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/widgets/Drawer.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<Widget> _abas = <Widget>[
    Podcasts(),
    Playlist(),
    Baixados(),
    EmAlta(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                MaterialPageRoute(builder: (_) => Search()),
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
