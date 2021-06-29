import 'package:flutter/material.dart';
import 'package:m_vd/file_manager/app_home/app.dart';
import 'package:m_vd/file_manager/app_home/tab_item.dart';
import 'package:m_vd/file_manager/data/constants.dart';

class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onSelecttab;
  final List<TabItem> tabs;
  const BottomNavigation(
      {required this.onSelecttab, required this.tabs, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),
              icon: e.icon,
              tabName: e.tabName,
            ),
          )
          .toList(),
      onTap: (index) => onSelecttab(index),
      selectedItemColor: Colors.white38,
      unselectedItemColor: Colors.white38,
      selectedFontSize: 12,
      backgroundColor: navColor,
      elevation: 0,
    );
  }
}

BottomNavigationBarItem _buildItem(
    {required int index, required IconData icon, required String tabName}) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      color: _tabColor(index: index),
    ),
    label: tabName,
  );
}

Color _tabColor({required int index}) {
  return AppPageState.currentTab == index ? Colors.white60 : Colors.white38;
}
