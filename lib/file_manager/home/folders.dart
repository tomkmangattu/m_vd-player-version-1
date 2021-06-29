import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/cubit/localstorage_cubit.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';
import 'package:m_vd/file_manager/video/screens/folder_screen.dart';

class HomeFolders extends StatelessWidget {
  const HomeFolders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalstorageCubit, LocalstorageState>(
      //
      buildWhen: (previous, current) {
        if (previous is InternalLoaded && current is InternalOnlyLoaded)
          return false;
        return true;
      },
      builder: (context, state) {
        if (state is InternalLoaded) {
          final List<String> folderNames = context
              .read<LocalstorageCubit>()
              .internalFolders
              .videoFolders
              .keys
              .toList();
          return _gridView(true, folderNames, Colors.blue, context);
        } else if (state is SdCardAndInternalLoaded) {
          final List<String> folderNames = context
              .read<LocalstorageCubit>()
              .internalFolders
              .videoFolders
              .keys
              .toList();
          final List<String> folderNamesSd = context
              .read<LocalstorageCubit>()
              .externalFolders
              .videoFolders
              .keys
              .toList();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _gridView(true, folderNames, Colors.blue, context),
              _gridView(false, folderNamesSd, Colors.cyan, context),
            ],
          );
        } else if (state is InternalOnlyLoaded) {
          final List<String> folderNames = context
              .read<LocalstorageCubit>()
              .internalFolders
              .videoFolders
              .keys
              .toList();
          return _gridView(true, folderNames, Colors.blue, context);
        } else if (state is SdCardOnlyLoaded) {
          final List<String> folderNamesSd = context
              .read<LocalstorageCubit>()
              .externalFolders
              .videoFolders
              .keys
              .toList();
          return _gridView(false, folderNamesSd, Colors.cyan, context);
        } else if (state is LocalstorageError) {
          return _error(state.error.toString());
        }
        return SizedBox();
      },
    );
  }

  Padding _error(final String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white38,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  GridView _gridView(final bool internal, List<String> folderNames, Color prim,
      BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      // childAspectRatio: (1 / 1),
      shrinkWrap: true,
      primary: true,
      children: folderNames.map((String folderName) {
        return _gridItem(
            internal: internal,
            folderName: folderName,
            prim: prim,
            context: context);
      }).toList(),
    );
  }

  Widget _gridItem({
    required final bool internal,
    required String folderName,
    required Color prim,
    required BuildContext context,
  }) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero, primary: prim),
      onPressed: () {
        _onpress(internal, folderName, context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder,
            size: 60,
          ),
          Text(
            (folderName.length > 10)
                ? folderName.substring(0, 8) + '..'
                : folderName,
          ),
        ],
      ),
    );
  }

  void _onpress(
      final bool internal, final String folderName, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ThumbnailCubit>(),
          child: FolderScreen(
            folderName: internal ? 'I:' + folderName : 'E:' + folderName,
          ),
        ),
      ),
    );
  }
}
