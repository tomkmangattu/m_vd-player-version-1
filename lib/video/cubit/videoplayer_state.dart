part of 'videoplayer_cubit.dart';

abstract class VideoplayerState extends Equatable {
  const VideoplayerState();

  @override
  List<Object> get props => [];
}

class VideoplayerInitial extends VideoplayerState {}

class VideoLoaded extends VideoplayerState {}

class VideoScreenTapShow extends VideoplayerState {}

class VideoScreenTapHide extends VideoplayerState {}
