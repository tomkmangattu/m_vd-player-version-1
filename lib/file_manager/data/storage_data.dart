import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/data/folder%20class.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:path/path.dart' as p;

class StorageData {
  late List folders;
  late final String _internalStoragePath;
  late final String _sdCardPath;
  late int storageDevNo;

  Future<Either<FoldersError, Folders>> getInternelStorgInfo() async {
    try {
      await getStorageInfo();
    } catch (_) {
      return Left(FoldersError(storageErrors: StorageErrors.lookUpFailed));
    }
    return await _getFoldersAndFiles(
      path: _internalStoragePath,
      internal: true,
    );
  }

  Future<Either<FoldersError, Folders>> getSdCardStorgInfo() async {
    if (storageDevNo > 1)
      return await _getFoldersAndFiles(path: _sdCardPath, internal: false);
    return Left(FoldersError(storageErrors: StorageErrors.sdCardNotPresent));
  }

  Future<void> getStorageInfo() async {
    late final List<StorageInfo> storageInfo;
    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } catch (_) {
      return Future.error('error');
    }
    // 0 => internal storage 1 => sd card
    if (storageInfo.isNotEmpty) {
      storageDevNo = storageInfo.length;
      _internalStoragePath = storageInfo[0].rootDir;
      if (storageInfo.length > 1) {
        _sdCardPath = storageInfo[1].rootDir;
      }
    } else {
      storageDevNo = 0;
    }
  }

  Future<Either<FoldersError, Folders>> _getFoldersAndFiles(
      {required final String path, required bool internal}) async {
    late final List<File> files;
    try {
      files = await _getAllFiles(path, internal);
    } catch (_) {
      return Left(FoldersError(
          storageErrors: internal
              ? StorageErrors.internalInfoFail
              : StorageErrors.sdInfoFail));
    }
    // get prefix '/storage/emulated/0/'
    // +1 to avoid last '/'
    final int parent = path.length + 1;
    Map<String, List<String>>? videoFolders = {};
    Map<String, List<String>>? audioFolders = {};
    // for all files
    for (final file in files) {
      final path = file.path;
      // video folders
      if (supportedVideoFormats.contains(p.extension(path))) {
        // print('v: ' + path);
        final folderName = path.substring(parent).split('/').first;
        if (videoFolders.containsKey(folderName))
          videoFolders[folderName]!.add(path);
        else
          videoFolders[folderName] = [path];
        // audio folders
      } else if (supportedAudioFiles.contains(p.extension(path))) {
        // print('s: ' + path);
        final folderName = path.substring(parent).split('/').first;
        if (audioFolders.containsKey(folderName))
          audioFolders[folderName]!.add(path);
        else
          audioFolders[folderName] = [path];
      }
    }
    Folders folder =
        Folders(videoFolders: videoFolders, audioFolders: audioFolders);
    print(
        'Video Folders: ${videoFolders.keys}\nAudio Folders: ${audioFolders.keys}');
    return Right(folder);
  }

  // get all files in internal storage or sd card
  // avoid app data folder ['/storage/emulated/0/Android']

  Future<List<File>> _getAllFiles(String path, bool internal) async {
    try {
      final fileManager = FileManager(root: Directory(path));
      final List<File> files = internal
          ? await fileManager
              .filesTree(excludedPaths: ["/storage/emulated/0/Android"])
          : await fileManager.filesTree();
      return files;
    } catch (e) {
      return Future.error('error');
    }
  }
}
