import 'dart:io';

import 'package:m_vd/file_manager/video/data/videoFolders.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbNailClass {
  String? _dirpath;
  bool _exists = false;

  Future<void> _getDirPath() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirpath = dir.path + '/thumbNail';
    _exists = await Directory(dirpath).exists();
    if (!_exists) {
      Directory(dirpath).create();
    }
    _dirpath = dirpath;
  }

  Future<VideoFolder> getVideoFolders(final VideoFolder videoFolders) async {
    if (_dirpath == null) {
      await _getDirPath();
    }
    // List<VideoFile> videoFiles = [];
    // for (final file in files) {
    //   late String path;
    //   try {
    //     path = await VideoThumbnail.thumbnailFile(
    //           video: file,
    //           imageFormat: ImageFormat.JPEG,
    //           thumbnailPath: _dirpath,
    //           quality: 5,
    //         ) ??
    //         '';
    //   } catch (_) {
    //     path = '';
    //   }
    //   final String orgName = file.split('/').last;
    //   videoFiles.add(VideoFile(name: orgName, path: file, thumbNailPath: path));
    // }

    List<VideoFile> videoFiles = [];
    for (final VideoFile vdf in videoFolders.videoFiles) {
      late String path;
      try {
        path = await VideoThumbnail.thumbnailFile(
                video: vdf.path,
                imageFormat: ImageFormat.JPEG,
                thumbnailPath: _dirpath,
                quality: 5) ??
            '';
      } catch (_) {
        path = '';
      }
      videoFiles.add(VideoFile(
        name: vdf.name,
        path: vdf.path,
        thumbNailPath: path,
      ));
    }

    return VideoFolder(
        folderName: videoFolders.folderName, videoFiles: videoFiles);
  }
}
