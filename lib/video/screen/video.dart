import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/video/cubit/videoplayer_cubit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCustom extends StatefulWidget {
  final double height;
  final double width;
  const VideoPlayerCustom({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  _VideoPlayerCustomState createState() => _VideoPlayerCustomState();
}

class _VideoPlayerCustomState extends State<VideoPlayerCustom> {
  @override
  Widget build(BuildContext context) {
    final size = context.read<VideoplayerCubit>().getSize;
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: VideoPlayer(
            context.read<VideoplayerCubit>().videoPlayerController,
          ),
        ),
      ),
    );
  }
}
