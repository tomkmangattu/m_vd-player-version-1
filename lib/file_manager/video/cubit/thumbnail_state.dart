part of 'thumbnail_cubit.dart';

abstract class ThumbnailState extends Equatable {
  const ThumbnailState();

  @override
  List<Object> get props => [];
}

class ThumbnailInitial extends ThumbnailState {}

class ThumbnailLoading extends ThumbnailState {}

class ThumbnailLoaded extends ThumbnailState {
  final int index;
  ThumbnailLoaded({required this.index});
}

class ThumbnailLoadedNew extends ThumbnailState {
  final int index;
  ThumbnailLoadedNew({required this.index});
}

class ThumbnailError extends ThumbnailState {}
