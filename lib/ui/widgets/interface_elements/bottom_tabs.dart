import 'package:photogram_app/domain/enums/tab_item.dart';
import 'package:photogram_app/ui/widgets/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomTabs extends StatelessWidget {
  final TabItemsEnum currentTab;
  final ValueChanged<TabItemsEnum> onSelectTab;

  const BottomTabs(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppViewModel>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedFontSize: 12.0,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.grey[700],
      currentIndex: currentTab.index,
      items: TabItemsEnum.values.map((e) => _buildItem(e, appModel)).toList(),
      onTap: (value) {
        FocusScope.of(context).unfocus();
        onSelectTab(TabItemsEnum.values[value]);
      },
    );
  }

  BottomNavigationBarItem _buildItem(
      TabItemsEnum tabItem, AppViewModel appmodel) {
    var icon = tabItem != TabItemsEnum.profile
        ? Icon(
            TabItems.tabIcons[tabItem],
          )
        : CircleAvatar(
            backgroundImage: appmodel.avatar?.image,
          );

    return BottomNavigationBarItem(
        label: TabItems.tabNames[tabItem], icon: icon);
  }
}
