import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';
import 'package:m_vd/file_manager/video/screens/folder_screen.dart';

class VideoScreen extends StatelessWidget {
  final String? filterString; // I: internal only  E: external only null both
  const VideoScreen({this.filterString, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _heigth = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: _heigth),
      decoration: BoxDecoration(
        gradient: bgmGradient,
      ),
      child: BlocBuilder<ThumbnailCubit, ThumbnailState>(
        buildWhen: (previous, current) {
          if (current is ThumbnailLoading) return true;
          return false;
        },
        builder: (context, state) {
          if (state is ThumbnailInitial) {
            return SizedBox();
          } else {
            final List<String> folders = _getList(context);
            final tabs = _getTabs(folders);
            final tabView = _getTabView(folders);
            return DefaultTabController(
              length: folders.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: tabs,
                    isScrollable: true,
                  ),
                  Flexible(child: TabBarView(children: tabView)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  List<String> _getList(BuildContext context) {
    final folders = context.read<ThumbnailCubit>().folderNames;
    print(filterString);
    if (filterString == null) {
      return folders;
    } else {
      List<String> filteredFolders = [];
      if (filterString == 'I:') {
        for (final folder in folders) {
          if (folder[0] == 'I') filteredFolders.add(folder);
        }
      } else {
        for (final folder in folders) {
          if (folder[0] == 'E') filteredFolders.add(folder);
        }
      }
      return filteredFolders;
    }
  }

  List<Widget> _getTabs(final List<String> folderNames) {
    List<Widget> tabs = [];
    for (String folder in folderNames) {
      if (folder.length > 12) folder = folder.substring(0, 10) + '..';
      tabs.add(Tab(
        text: folder.substring(2),
      ));
    }
    return tabs;
  }

  List<Widget> _getTabView(final List<String> folderNames) {
    List<Widget> tabView = [];
    for (final folder in folderNames) {
      tabView.add(FolderScreen(folderName: folder));
    }
    return tabView;
  }
}
