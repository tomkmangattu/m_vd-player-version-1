import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';
import 'package:m_vd/file_manager/video/data/videoFolders.dart';
import 'package:m_vd/file_manager/video/screens/video_items.dart';

class FolderScreen extends StatelessWidget {
  final String folderName;
  const FolderScreen({required this.folderName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final folderIndex =
        context.read<ThumbnailCubit>().getFolderIndex(folderName);
    final List<VideoFile> videoFiles =
        context.read<ThumbnailCubit>().getVideoList(folderIndex);

    print(folderIndex);
    return Container(
      decoration: BoxDecoration(
        gradient: bgmGradient,
      ),
      child: ListView.builder(
        itemCount: videoFiles.length,
        itemBuilder: (BuildContext context, int index) {
          return VideoItem(folderIndex: folderIndex, listIndex: index);
        },
      ),
    );
  }
}
