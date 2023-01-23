import 'package:photogram_app/data/services/user_service.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:photogram_app/ui/widgets/interface_elements/users_feed.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FollowersViewModel extends ChangeNotifier {
  BuildContext context;
  final _userService = UserService();

  List<UserShort>? _users;
  List<UserShort>? get users => _users;
  set users(List<UserShort>? val) {
    _users = val;
    notifyListeners();
  }

  FollowersViewModel({required this.context}) {
    asyncInit();
  }

  void asyncInit() async {
    users = await _userService.getCurrentUserFollowers();
  }
}

class Followers extends StatelessWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(snowStatusBar); //!!!!
    var viewModel = context.watch<FollowersViewModel>();

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
      create: (BuildContext context) => FollowersViewModel(context: context),
      child: const Followers(),
    );
  }
}
