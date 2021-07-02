import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:m_vd/file_manager/music/data/musicFolder.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  late final List<MusicFolder> musicFolders;
  late final List<String> folderNames;
  MusicCubit() : super(MusicInitial());

  void initialise(
      {final Map<String, List<String>>? inFolders,
      final Map<String, List<String>>? exFolders}) {
    if (inFolders != null && exFolders != null) {
      Map<String, List<String>> allFolders = inFolders;
      allFolders.addAll(exFolders);
      _initialise(allFolders);
    } else if (inFolders != null) {
      _initialise(inFolders);
    } else if (exFolders != null) {
      _initialise(exFolders);
    }
  }

  void _initialise(final Map<String, List<String>> allFolders) {
    List<MusicFolder> _musicFoldes = [];
    List<String> _folderNames = [];
    for (final String folderNames in allFolders.keys) {
      final folder = allFolders[folderNames];
      _folderNames.add(folderNames);
      if (folder != null) {
        _musicFoldes.add(MusicFolder(name: folderNames, files: folder));
      }
    }
    musicFolders = _musicFoldes;
    folderNames = _folderNames;
    emit(MusicLoaded());
  }
}
