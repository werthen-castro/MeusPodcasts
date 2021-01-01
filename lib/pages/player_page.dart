import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:meuspodcast/bloc/player_bloc.dart';
import 'package:meuspodcast/colors.dart';
import 'package:meuspodcast/widgets/drawer.dart';

typedef _Fn = void Function();

class SimpleRecorder extends StatefulWidget {
  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder> {
  PlayerBloc _playerBloc = PlayerBloc();
  double _value = 0;
  String dropdownValue = '1x';

  @override
  void initState() {
    _playerBloc.initSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Meus Podcasts',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.share,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              color: Colors.grey,
              child: Image.network(
                '',
                height: 320,
                width: 320,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              min: 0,
              max: 100,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 24, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '60.00',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // StreamBuilder<FlutterSoundRecorder>(
              //     stream: _playerBloc.mRecorder,
              //     builder: (context, snapshot) {
              //       return IconButton(
              //           color: Colors.white,
              //           iconSize: 44,
              //           icon: snapshot.hasData && snapshot.data.isRecording
              //               ? Icon(Icons.stop)
              //               : Icon(Icons.mic),
              //           onPressed: () {
              //             log(snapshot.hasData.toString() +
              //                 ' ' +
              //                 snapshot.data.isRecording.toString());
              //             if (snapshot.hasData && snapshot.data.isRecording) {
              //               _playerBloc.stopRecorder();
              //             } else {
              //               _playerBloc.record();
              //             }

              //             setState(() {});
              //           });
              //     }),
              IconButton(
                  iconSize: 28,
                  color: Colors.white,
                  icon: Icon(Feather.cast),
                  onPressed: () {}),
              IconButton(
                  iconSize: 38,
                  color: Colors.white,
                  icon: Icon(FontAwesome.backward),
                  onPressed: () {}),
              StreamBuilder<FlutterSoundPlayer>(
                  stream: _playerBloc.mPlayer,
                  builder: (context, snapshot) {
                    return IconButton(
                        color: Colors.white,
                        iconSize: 75,
                        icon: snapshot.hasData && snapshot.data.isPlaying
                            ? Icon(Icons.stop)
                            : Icon(FontAwesome.play_circle),
                        onPressed: () {
                          if (snapshot.hasData && snapshot.data.isPlaying) {
                            _playerBloc.stopPlayer();
                          } else {
                            _playerBloc.play();
                          }

                          setState(() {});
                        });
                  }),
              IconButton(
                  iconSize: 38,
                  color: Colors.white,
                  icon: Icon(FontAwesome.forward),
                  onPressed: () {}),
              Container(
                width: 50,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.primaryColor,
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Container(),
                    isExpanded: true,
                    iconSize: 24,
                    elevation: 10,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['1x', '1.25x', '1.5x', '2x']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
