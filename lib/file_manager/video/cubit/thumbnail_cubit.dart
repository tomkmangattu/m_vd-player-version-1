import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:m_vd/file_manager/video/data/thumbNailClass.dart';
import 'package:m_vd/file_manager/video/data/videoFolders.dart';

part 'thumbnail_state.dart';

class ThumbnailCubit extends Cubit<ThumbnailState> {
  List<VideoFolder> videoFolders = [];
  List<String> folderNames = [];
  ThumbNailClass _thumbNail = ThumbNailClass();
  ThumbnailCubit() : super(ThumbnailInitial());

  void initialise({
    Map<String, List<String>>? infolders,
    Map<String, List<String>>? exfolders,
  }) {
    // Map<String, List<String>> allFolders = {};
    if (infolders != null) {
      // allFolders.addAll(infolders.map(
      //   (key, value) => MapEntry('I:' + key, value),
      // ));
      infolders.forEach((key, value) {
        _initialise('I:' + key, value);
      });
    }
    if (exfolders != null) {
      // allFolders.addAll(
      //   exfolders.map((key, value) => MapEntry('E:' + key, value)),
      // );
      exfolders.forEach((key, value) {
        _initialise('E:' + key, value);
      });
    }
    print('All video folders :' + folderNames.toString());
    emit(ThumbnailLoading());
    _getThumbNailPaths();
  }

  void _getThumbNailPaths() async {
    // for (final String folderName in allFolders.keys) {
    //   final List<String> files = allFolders[folderName] ?? [];

    //   if (files.isNotEmpty) {
    //     videoFolders.add(await _thumbNail.getVideoFolders(folderName, files));
    //   }
    //   _emitLoaded(i);
    //   i++;
    // }
    int i = 0;
    for (final VideoFolder videoFolder in videoFolders) {
      videoFolders[i] = await _thumbNail.getVideoFolders(videoFolder);
      _emitLoaded(i);
      i++;
    }
    print('${videoFolders.length}  $i');
  }

  void _emitLoaded(final int no) {
    print('#################### loaded :' + folderNames[no].toString());
    if (state is ThumbnailLoaded)
      emit(ThumbnailLoadedNew(index: no));
    else
      emit(ThumbnailLoaded(index: no));
  }

  void _initialise(final String folderName, List<String> folders) {
    List<VideoFile> videoFiles = [];
    folderNames.add(folderName);
    for (final String folder in folders) {
      final String baseName = folder.split('/').last;
      videoFiles.add(VideoFile(name: baseName, path: folder));
    }
    videoFolders
        .add(VideoFolder(folderName: folderName, videoFiles: videoFiles));
  }

  List<VideoFile> getVideoList(final int no) {
    return videoFolders[no].videoFiles;
  }

  String? thumbPath(final int no, final int index) {
    return videoFolders[no].videoFiles[index].thumbNailPath;
  }

  int getFolderIndex(final String folderName) {
    int no = 0;
    for (final String folder in folderNames) {
      if (folder == folderName) {
        break;
      } else {
        no++;
      }
    }
    return no;
  }
}
