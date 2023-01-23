import 'package:photogram_app/data/services/user_service.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:photogram_app/ui/widgets/interface_elements/users_feed.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FollowingsViewModel extends ChangeNotifier {
  BuildContext context;
  final _userService = UserService();

  List<UserShort>? _users;
  List<UserShort>? get users => _users;
  set users(List<UserShort>? val) {
    _users = val;
    notifyListeners();
  }

  FollowingsViewModel({required this.context}) {
    asyncInit();
  }

  void asyncInit() async {
    users = await _userService.getCurrentUserFollowings();
  }
}

class Followings extends StatelessWidget {
  const Followings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(snowStatusBar); //!!!!
    var viewModel = context.watch<FollowingsViewModel>();

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: UsersFeed(
          feedUsers: viewModel.users,
          onTap: (id) {}, //!!!!
        )));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FollowingsViewModel(context: context),
      child: const Followings(),
    );
  }
}
