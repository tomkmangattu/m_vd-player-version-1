import 'package:flutter/material.dart';
import 'package:m_vd/file_manager/app_home/app.dart';

class TabItem {
  final String tabName;
  final IconData icon;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  late Widget _page;
  TabItem({
    required this.tabName,
    required this.icon,
    required Widget page,
  }) {
    _page = page;
  }

  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

  Widget get page {
    return Visibility(
      visible: _index == AppPageState.currentTab,
      maintainState: true,
      child: Navigator(
        key: key,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(
            builder: (_) => _page,
          );
        },
      ),
    );
  }
}
