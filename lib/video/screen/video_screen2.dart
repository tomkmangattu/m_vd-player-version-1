import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/video/cubit/videoplayer_cubit.dart';
import 'package:m_vd/video/data/constants.dart';
import 'package:m_vd/video/screen/video.dart';
import 'package:video_player/video_player.dart';
import 'package:m_vd/video/screen/playButton.dart';

class VideoScreen2 extends StatelessWidget {
  final String path;
  const VideoScreen2({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _bottomPadding = MediaQuery.of(context).padding.bottom;
    return BlocProvider<VideoplayerCubit>(
      create: (_) => VideoplayerCubit(path: path),
      child: Builder(
        builder: (context) {
          return BlocBuilder<VideoplayerCubit, VideoplayerState>(
            buildWhen: (previous, current) {
              if (current is VideoLoaded) return true;
              return false;
            },
            builder: (context, state) {
              if (state is VideoplayerInitial) {
                return _loading();
              } else {
                return Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    VideoPlayerCustom(height: _height, width: _width),
                    GestureDetector(
                      onTap: context.read<VideoplayerCubit>().onTap,
                    ),
                    BlocBuilder<VideoplayerCubit, VideoplayerState>(
                      buildWhen: (previous, current) {
                        if (current is VideoScreenTapShow ||
                            current is VideoScreenTapHide) return true;
                        return false;
                      },
                      builder: (context, state) {
                        if (state is VideoScreenTapShow) {
                          return _bottomElements(context, _bottomPadding);
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  Align _bottomElements(BuildContext context, double padding) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              PlayButton(),
              Flexible(child: _videoProgressIndicator(context)),
            ],
          ),
        ),
      ),
    );
  }

  Padding _videoProgressIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: VideoProgressIndicator(
        context.read<VideoplayerCubit>().videoPlayerController,
        allowScrubbing: true,
      ),
    );
  }

  Center _loading() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
