import 'package:photogram_app/ui/widgets/tab_messages/messages.dart';
import 'package:photogram_app/ui/widgets/tab_new_post/new_post.dart';
import 'package:photogram_app/ui/widgets/tab_home/home.dart';
import 'package:photogram_app/ui/widgets/tab_profile/profile.dart';
import 'package:photogram_app/ui/widgets/tab_search/search.dart';
import 'package:flutter/material.dart';

enum TabItemsEnum { home, search, newPost, messages, profile }

class TabItems {
  static const TabItemsEnum defTab = TabItemsEnum.home;

  static Map<TabItemsEnum, IconData> tabIcons = {
    TabItemsEnum.home: Icons.home_filled,
    TabItemsEnum.search: Icons.search,
    TabItemsEnum.newPost: Icons.add_circle_outline_rounded,
    TabItemsEnum.messages: Icons.messenger_rounded,
    TabItemsEnum.profile: Icons.person,
  };

  static Map<TabItemsEnum, String> tabNames = {
    TabItemsEnum.home: "Home",
    TabItemsEnum.search: "Search",
    TabItemsEnum.newPost: "New post",
    TabItemsEnum.messages: "Messages",
    TabItemsEnum.profile: "Profile",
  };

  static Map<TabItemsEnum, Widget> tabRoots = {
    TabItemsEnum.home: Home.create(),
    TabItemsEnum.search: Search.create(),
    TabItemsEnum.newPost: NewPost.create(),
    TabItemsEnum.messages: Messages.create(),
    TabItemsEnum.profile: Profile.create(),
  };
}
