import 'package:photogram_app/domain/enums/tab_item.dart';
import 'package:photogram_app/ui/widgets/screens/app.dart';
import 'package:photogram_app/ui/widgets/screens/auth.dart';
import 'package:photogram_app/ui/widgets/screens/loader.dart';
import 'package:photogram_app/ui/widgets/screens/sign_up.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loaderWidget = "/";
  static const auth = "/auth";
  static const app = "/app";
  static const registration = "/signUp";
  static const postCreating = "/postCreating";
}

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

  static final navigationKeys = {
    TabItemsEnum.home: GlobalKey<NavigatorState>(),
    TabItemsEnum.search: GlobalKey<NavigatorState>(),
    TabItemsEnum.newPost: GlobalKey<NavigatorState>(),
    TabItemsEnum.messages: GlobalKey<NavigatorState>(),
    TabItemsEnum.profile: GlobalKey<NavigatorState>(),
  };

  static Future toLoader() async {
    return await key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loaderWidget, ((route) => false));
  }

  static Future toAuth() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, ((route) => false));
  }

  static Future toHome() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.app, ((route) => false));
  }

  static Future toRegistration() async {
    return await key.currentState?.pushNamed(NavigationRoutes.registration);
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loaderWidget:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoaderWidget.create());
      case NavigationRoutes.auth:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Auth.create());
      case NavigationRoutes.app:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => App.create());
      case NavigationRoutes.registration:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignUp.create());
    }
    return null;
  }
}
