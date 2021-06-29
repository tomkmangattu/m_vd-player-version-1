import 'package:m_vd/file_manager/data/constants.dart';

class Folders {
  final Map<String, List<String>> videoFolders;
  final Map<String, List<String>> audioFolders;
  Folders({required this.videoFolders, required this.audioFolders});
}

class FoldersError {
  final StorageErrors storageErrors;
  FoldersError({required this.storageErrors});
}
