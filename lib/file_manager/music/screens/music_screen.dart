import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/cubit/localstorage_cubit.dart';
import 'package:m_vd/file_manager/data/constants.dart';
import 'package:m_vd/file_manager/music/cubit/music_cubit.dart';
import 'package:m_vd/file_manager/music/screens/music%20list%20view.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _topPadding = MediaQuery.of(context).padding.top;
    return BlocProvider<MusicCubit>(
      create: (context) => MusicCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<LocalstorageCubit, LocalstorageState>(
            listenWhen: (previous, current) {
              if (current is SdCardAndInternalLoaded ||
                  current is SdCardOnlyLoaded ||
                  current is InternalOnlyLoaded) return true;
              return false;
            },
            listener: (context, state) {
              if (state is SdCardAndInternalLoaded) {
                context.read<MusicCubit>().initialise(
                      inFolders: context
                          .read<LocalstorageCubit>()
                          .internalFolders
                          .audioFolders,
                      exFolders: context
                          .read<LocalstorageCubit>()
                          .externalFolders
                          .audioFolders,
                    );
              } else if (state is InternalOnlyLoaded) {
                context.read<MusicCubit>().initialise(
                      inFolders: context
                          .read<LocalstorageCubit>()
                          .internalFolders
                          .audioFolders,
                    );
              } else if (state is SdCardOnlyLoaded) {
                context.read<MusicCubit>().initialise(
                      exFolders: context
                          .read<LocalstorageCubit>()
                          .externalFolders
                          .audioFolders,
                    );
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: _topPadding),
              decoration: BoxDecoration(
                gradient: bgmGradient,
              ),
              child: BlocBuilder<MusicCubit, MusicState>(
                buildWhen: (previous, current) {
                  if (current is MusicLoaded) return true;
                  return false;
                },
                builder: (context, state) {
                  if (state is MusicInitial) {
                    return SizedBox();
                  } else {
                    final folderNames = context.read<MusicCubit>().folderNames;

                    final tabs = _getTabs(folderNames);
                    final musicList = _getMusicList(folderNames.length);
                    return DefaultTabController(
                      length: folderNames.length,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: tabs,
                            isScrollable: true,
                          ),
                          Flexible(
                            child: TabBarView(
                              children: musicList,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<Tab> _getTabs(final List<String> folderNames) {
    List<Tab> tabs = [];
    folderNames.forEach((String names) {
      if (names.length > 10) {
        names = names.substring(0, 8) + '..';
      }
    });
    for (final String folderName in folderNames) {
      tabs.add(Tab(
        text: folderName,
      ));
    }
    return tabs;
  }

  List<Widget> _getMusicList(final int no) {
    List<Widget> musicList = [];
    for (int i = 0; i < no; i++) {
      musicList.add(MusicList(no: i));
    }
    return musicList;
  }
}
