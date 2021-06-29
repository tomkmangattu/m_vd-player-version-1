import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/data/context_provider.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';
import 'package:m_vd/file_manager/video/data/videoFolders.dart';

import 'package:m_vd/video/screen/video_screen2.dart';
// import 'package:m_vd/video/video_screen.dart';
import 'package:provider/provider.dart';

const double _imageHeight = 40;
const double _imageWidth = 60;

class VideoItem extends StatelessWidget {
  final int folderIndex;
  final int listIndex;
  const VideoItem({
    required this.folderIndex,
    required this.listIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoFile item =
        context.read<ThumbnailCubit>().getVideoList(folderIndex)[listIndex];
    late final String name;
    if (item.name.length > 25) {
      name = item.name.substring(0, 20) + '...' + item.name.split('.').last;
    } else {
      name = item.name;
    }
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(4.0),
      ),
      onPressed: () {
        _onpressed(context, item.path);
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.withOpacity(.1)),
        ),
        child: Row(
          children: [
            SizedBox(
              height: _imageHeight,
              width: _imageWidth,
              child: BlocBuilder<ThumbnailCubit, ThumbnailState>(
                buildWhen: (previous, current) {
                  if ((current is ThumbnailLoaded &&
                          current.index == folderIndex + 1) ||
                      (current is ThumbnailLoadedNew &&
                          current.index == folderIndex + 1)) return true;
                  return false;
                },
                builder: (context, state) {
                  // print('reload');

                  final path = context
                      .read<ThumbnailCubit>()
                      .thumbPath(folderIndex, listIndex);
                  if (path != null) {
                    // print(path);
                    if (path.isNotEmpty) {
                      final file = File(path);
                      return Image.file(file, fit: BoxFit.cover);
                    }
                  }
                  // print(item.path);
                  return FittedBox(
                    child: Container(
                      color: Colors.black,
                      child: const SizedBox(
                        width: _imageWidth,
                        height: _imageHeight,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }

  void _onpressed(final BuildContext context, final String path) {
    final ctx = Provider.of<ContextProvider>(context, listen: false).context;
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => VideoScreen2(
          path: path,
        ),
      ),
    );
  }
}
