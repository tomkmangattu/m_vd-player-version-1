import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/music/cubit/music_cubit.dart';
import 'package:m_vd/file_manager/music/data/musicFolder.dart';
import 'package:m_vd/music/test_audioPlayer.dart';

class MusicList extends StatelessWidget {
  final int no;
  const MusicList({required this.no, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicFolder musicFolder = context.read<MusicCubit>().musicFolders[no];

    return ListView.builder(
      itemCount: musicFolder.files.length,
      itemBuilder: (_, int index) {
        final String fileName = musicFolder.files[index];
        return _musicItem(fileName, index, no, context);
      },
    );
  }

  Widget _musicItem(final String name, final int index, final int folderIndex,
      final BuildContext context) {
    late String musicName;
    final n1 = name.split('/').last.split('.').first;
    if (n1.length > 30) {
      musicName = n1.substring(0, 28) + '..';
    } else {
      musicName = n1;
    }
    return TextButton(
      onPressed: () => _onpress(context, folderIndex, index),
      child: Row(
        children: [
          Icon(
            Icons.library_music,
            size: 30,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            musicName,
            style: TextStyle(
              color: Colors.cyan,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _onpress(
    BuildContext context,
    final int folderIndex,
    final int fileIndex,
  ) {
    final MusicFolder musicFolder =
        context.read<MusicCubit>().musicFolders[folderIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AudioPlayerPage(musicFolder: musicFolder, fileIndex: fileIndex),
      ),
    );
  }
}
