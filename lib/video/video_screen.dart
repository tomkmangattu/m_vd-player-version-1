import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoScreen extends StatefulWidget {
  static const String id = 'video screen';
  final String path;
  const VideoScreen({required this.path, Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _addVideoController();

    // SystemChrome.setEnabledSystemUIOverlays([]);
    // set orientation to landscape
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    Wakelock.enable();

    super.initState();
  }

  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    Wakelock.disable();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  // void _addVideoController() {
  //   _videoPlayerController = VideoPlayerController.network(
  //       'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
  //     ..initialize().then((value) => setState(() {}));
  // }

  void _addVideoController() {
    File file = File(widget.path);
    _videoPlayerController = VideoPlayerController.file(file)
      ..initialize().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          fit: StackFit.passthrough,
          alignment: AlignmentDirectional.center,
          children: [
            _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            SystemChrome.setEnabledSystemUIOverlays([]);
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Icon(Icons.play_arrow),
      ),
      backgroundColor: Colors.red,
    );
  }
}
