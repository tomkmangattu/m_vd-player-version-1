import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/music/data/musicFolder.dart';
import 'package:m_vd/music/gramophone.dart';

class AudioPlayerPage extends StatefulWidget {
  final MusicFolder musicFolder;
  final int fileIndex;
  const AudioPlayerPage(
      {required this.musicFolder, required this.fileIndex, Key? key})
      : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    _setUp();
    super.initState();
  }

  void _setUp() async {
    List<AudioSource> _audioSources = widget.musicFolder.files
        .map((String path) => AudioSource.uri(Uri.parse(path)))
        .toList();
    await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: _audioSources),
        initialIndex: widget.fileIndex);
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    final _topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: _topPadding),
      decoration: BoxDecoration(gradient: bgmGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: CustomPaint(
              size: Size(300, 300),
              painter: Gramophone(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    _audioPlayer.seekToNext();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 35,
                    color: Colors.cyanAccent,
                  )),
              _audioPlayer.playing
                  ? IconButton(
                      onPressed: () {
                        _audioPlayer.pause();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.pause_circle,
                        size: 40,
                        color: Colors.cyanAccent,
                      ))
                  : IconButton(
                      onPressed: () {
                        _audioPlayer.play();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.play_circle,
                        size: 40,
                        color: Colors.cyanAccent,
                      )),
              IconButton(
                  onPressed: () {
                    _audioPlayer.seekToPrevious();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 35,
                    color: Colors.cyanAccent,
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
