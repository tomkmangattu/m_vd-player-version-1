import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_vd/file_manager/app_home/bottomNavigation.dart';
import 'package:m_vd/file_manager/app_home/tab_item.dart';
import 'package:m_vd/file_manager/cubit/localstorage_cubit.dart';
import 'package:m_vd/file_manager/data/context_provider.dart';
import 'package:m_vd/file_manager/home/home_screen.dart';
import 'package:m_vd/file_manager/music/screens/music_screen.dart';
import 'package:m_vd/file_manager/settings/setting_page.dart';
import 'package:m_vd/file_manager/video/cubit/thumbnail_cubit.dart';
import 'package:m_vd/file_manager/video/screens/video_screen.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  static const String id = 'app home';
  const AppPage({Key? key}) : super(key: key);

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  // static so that other widgets can acess by AppState.currentTab
  static int currentTab = 0;
  // tab list
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Home",
      icon: Icons.home_rounded,
      page: HomeScrren(),
    ),
    TabItem(
      tabName: "Videos",
      icon: Icons.play_arrow,
      page: VideoScreen(),
    ),
    TabItem(
      tabName: 'Music',
      icon: Icons.music_note,
      page: MusicScreen(),
    ),
    TabItem(
      tabName: 'Settings',
      icon: Icons.settings,
      page: SettingsScreen(),
    ),
  ];
  //set index to every tab
  AppPageState() {
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }
  //set current tab index and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      //pop tp first route if user taps on active tab
      tabs[index].key.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentTab = index;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  final ThumbnailCubit _thumbnailCubit = ThumbnailCubit();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstPouteInCurrentTab =
            !await tabs[currentTab].key.currentState!.maybePop();
        if (isFirstPouteInCurrentTab) {
          // if not main tab
          if (currentTab != 0) {
            // select main tab
            _selectTab(0);
            // back button handed by app
            return false;
          }
        }
        return isFirstPouteInCurrentTab;
      },
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LocalstorageCubit(
                thumbnailCubit: _thumbnailCubit,
              ),
            ),
            BlocProvider(
              create: (_) => _thumbnailCubit,
            )
          ],
          child: Provider(
            create: (_) => ContextProvider(context: context),
            child: IndexedStack(
              index: currentTab,
              children: tabs.map((e) => e.page).toList(),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          onSelecttab: _selectTab,
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _thumbnailCubit.close();
    super.dispose();
  }
}
