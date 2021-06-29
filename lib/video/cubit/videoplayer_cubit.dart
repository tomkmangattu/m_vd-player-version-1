import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:m_vd/video/data/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

part 'videoplayer_state.dart';

class VideoplayerCubit extends Cubit<VideoplayerState> {
  final String path;
  bool _videoPlaying = false;
  bool _overlayVisible = false;
  late final VideoPlayerController videoPlayerController;
  VideoplayerCubit({required this.path}) : super(VideoplayerInitial()) {
    _arrangeUi();
    _initialiseController();
  }

  void _arrangeUi() {
    // status bar and navigation bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    // set orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _initialiseController() {
    final file = File(path);
    videoPlayerController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        emit(VideoLoaded());
      });
    _play();
  }

  double get getAspectRatio {
    return videoPlayerController.value.aspectRatio;
  }

  void playPauseButtonTap() {
    if (!_videoPlaying)
      _play();
    else
      _pause();
  }

  void onTap() {
    print('tapped');
    if (!(_overlayVisible)) {
      emit(VideoScreenTapShow());
      _overlayVisible = true;
      _dismissTap();
    } else {
      emit(VideoScreenTapHide());
      _overlayVisible = false;
    }
  }

  Future<void> _dismissTap() async {
    for (int i = 0; i < 3; i++) {
      await Future.delayed(Duration(seconds: 1));
      if (!_overlayVisible) return;
    }
    _overlayVisible = false;
    emit(VideoScreenTapHide());
  }

  Size get getSize {
    return videoPlayerController.value.size;
  }

  bool get isPlaying {
    return videoPlayerController.value.isPlaying;
  }

  void _play() {
    videoPlayerController.play();
    _videoPlaying = true;
    // emit(VideoPlay());
    Wakelock.enable();
  }

  void _pause() {
    videoPlayerController.pause();
    _videoPlaying = false;
    // emit(VideoPause());
    Wakelock.disable();
  }

  void _onPop() async {
    // set orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    // status bar and navigation bar
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    if (await Wakelock.enabled) {
      Wakelock.disable();
    }
  }

  @override
  Future<void> close() {
    videoPlayerController.dispose();
    _onPop();
    print('clossed.....');
    return super.close();
  }
}
