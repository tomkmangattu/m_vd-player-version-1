import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/video/cubit/videoplayer_cubit.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    bool _isPlaying = context.read<VideoplayerCubit>().isPlaying;
    return IconButton(
      splashColor: Colors.transparent,
      icon: Icon(
        _isPlaying ? Icons.pause : Icons.play_arrow,
        size: 30,
      ),
      onPressed: () {
        context.read<VideoplayerCubit>().playPauseButtonTap();
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
    );
  }
}
