import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class PlayerBloc{

  final _mPlayer = BehaviorSubject<FlutterSoundPlayer>();
  get mPlayer => _mPlayer.stream;

  final _mPlayerIsInited = BehaviorSubject<bool>.seeded(false);
  get mPlayerIsInited => _mPlayerIsInited.stream;

  final _mRecorder = BehaviorSubject<FlutterSoundRecorder>();
  get mRecorder => _mRecorder.stream;

  final _mRecorderIsInited = BehaviorSubject<bool>.seeded(false);
  get mRecorderIsInited => _mRecorderIsInited.stream;

  final _mplaybackReady = BehaviorSubject<bool>.seeded(false);
  get mplaybackReady => _mplaybackReady.stream;

  final _mPath = BehaviorSubject<String>();
  get mPath => _mPath.stream;

  initSound(){
    _mPlayer.add(FlutterSoundPlayer());
    _mRecorder.add(FlutterSoundRecorder());
    _mPlayer.value.openAudioSession().then((value) {
      print('init player');
      _mPlayerIsInited.add(true);
    });
    openTheRecorder().then((value) {
      print('init recorder');
      _mRecorderIsInited.add(true);
    });
  }

  Future<void> openTheRecorder() async {
    var tempDir = await getTemporaryDirectory();
    _mPath.add('${tempDir.path}/flutter_sound_example.aac');
    var outputFile = File(_mPath.value);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }
    await _mRecorder.value.openAudioSession();
  }
  
  Future<void> record() async {
    print('gravando');

    if (await Permission.microphone.request().isGranted) {
      print('gravando');
      await _mRecorder.value.startRecorder(
        toFile: _mPath.value,
        codec: Codec.aacADTS,
      );
    }
  }

  Future<void> stopRecorder() async {
    print('stop recorded');
          await _mRecorder.value.stopRecorder();
          _mplaybackReady.add(true);
  }

  void play() async {
    if (await Permission.microphone.request().isGranted) {
        await _mPlayer.value.startPlayer(
            fromURI: _mPath.value,
            codec: Codec.aacADTS,
            whenFinished: () {
        });
    }  
  }

  Future<void> stopPlayer() async {
    await _mPlayer.value.stopPlayer();
  }

  dispose(){
    _mPlayerIsInited.close();
    _mRecorderIsInited.close();
    _mplaybackReady.close();
    _mPath.close();
    mPlayer.closeAudioSession();
    mRecorder.closeAudioSession();
    _mPlayer.close();
    _mRecorder.close();
  }

}