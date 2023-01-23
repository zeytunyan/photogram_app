import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:photogram_app/ui/navigation/tab_navigator.dart';
import 'package:photogram_app/ui/widgets/interface_elements/bottom_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/enums/tab_item.dart';
import '../../../domain/models/user.dart';
import '../../../internal/config/app_config.dart';
import '../../../internal/config/shared_prefs.dart';

class AppViewModel extends ChangeNotifier {
  BuildContext context;
  TabItemsEnum? beforeTab;

  var _currentTab = TabItems.defTab;
  TabItemsEnum get currentTab => _currentTab;

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String? _msg;
  String? get msg => _msg;
  set msg(String? val) {
    _msg = val;
    if (val != null) {
      showSnackBar(val);
    }
    notifyListeners();
  }

  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  AppViewModel({required this.context}) {
    asyncInit();
    SystemChrome.setSystemUIOverlayStyle(snowStatusBar); //!!!!
  }

  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    avatar = Image.network(
      "$baseUrl${user!.avatarLink}",
      fit: BoxFit.contain,
    );
  }

  showSnackBar(String text) {
    var sb = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  void selectTab(TabItemsEnum tabItem) {
    SystemChrome.setSystemUIOverlayStyle(//!!!!
        tabItem == TabItemsEnum.profile ? royalBlueStatusBar : snowStatusBar);

    if (tabItem == _currentTab) {
      AppNavigator.navigationKeys[tabItem]!.currentState!
          .popUntil((route) => route.isFirst);
    } else {
      beforeTab = _currentTab;
      _currentTab = tabItem;
      notifyListeners();
    }
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AppViewModel>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
          onWillPop: () async {
            var isFirstRouteInCurrentTab = !await AppNavigator
                .navigationKeys[viewModel.currentTab]!.currentState!
                .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (viewModel.currentTab != TabItems.defTab) {
                viewModel.selectTab(TabItems.defTab);
              }
              return false;
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            bottomNavigationBar: BottomTabs(
              currentTab: viewModel.currentTab,
              onSelectTab: viewModel.selectTab,
            ),
            body: Stack(
                children: TabItemsEnum.values
                    .map((e) => _buildOffstageNavigator(context, e))
                    .toList()),
          )),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppViewModel(context: context),
      child: const App(),
    );
  }

  Widget _buildOffstageNavigator(BuildContext context, TabItemsEnum tabItem) {
    var viewModel = context.watch<AppViewModel>();

    return Offstage(
      offstage: viewModel.currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: AppNavigator.navigationKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
