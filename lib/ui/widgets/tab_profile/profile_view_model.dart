import 'dart:io';

import 'package:photogram_app/data/services/auth_service.dart';
import 'package:photogram_app/data/services/post_service.dart';
import 'package:photogram_app/data/services/user_service.dart';
import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/internal/config/app_config.dart';
import 'package:photogram_app/internal/dependencies/repository_module.dart';
import 'package:photogram_app/internal/utils.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:photogram_app/ui/navigation/tab_navigator.dart';
import 'package:photogram_app/ui/widgets/interface_elements/cam_widget.dart';
import 'package:photogram_app/ui/widgets/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/user.dart';
import '../../../../internal/config/shared_prefs.dart';

class ProfileViewModel extends ChangeNotifier {
  final _api = RepositoryModule.apiRepository();
  final _authService = AuthService();
  final _postService = PostService();
  final _userService = UserService();
  final BuildContext context;

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String? _imagePath;
  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  ProfileViewModel({required this.context}) {
    asyncInit();
    var appmodel = context.read<AppViewModel>();
    appmodel.addListener(() {
      avatar = appmodel.avatar;
    });
  }

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    posts = await _postService.getCurrentUserPosts(0, 5);
    if (user!.avatarLink == null) return;
    var img = await NetworkAssetBundle(Uri.parse("$baseUrl${user!.avatarLink}"))
        .load("$baseUrl${user!.avatarLink}?v=1");
    avatar = Image.memory(
      img.buffer.asUint8List(),
      fit: BoxFit.fill,
    );
  }

  Future logout() async {
    final sureWantTo = await showModal(
        title: "Logout",
        content: "Are you sure you want to logout?",
        context: context);

    if (!sureWantTo) return;
    await _authService.logout();
    AppNavigator.toLoader();
  }

  Future deleteUser() async {
    final sureWantTo = await showModal(
        title: "Delete account",
        content: "Are you sure you want to delete your account?",
        context: context);

    if (!sureWantTo) return;
    await _userService.deleteCurrentUser();
    AppNavigator.toLoader();
  }

  void toPostDetail(String postId) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
  }

  void toFollowers() {
    Navigator.of(context).pushNamed(TabNavigatorRoutes.followers);
  }

  void toFollowings() {
    Navigator.of(context).pushNamed(TabNavigatorRoutes.followings);
  }

  Future changePhoto() async {
    var appmodel = context.read<AppViewModel>();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (newContext) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: CamWidget(
            onFile: (file) {
              _imagePath = file.path;
              Navigator.of(newContext).pop();
            },
          ),
        ),
      ),
    ));
    if (_imagePath != null) {
      avatar = null;
      var t = await _api.uploadTemp(files: [File(_imagePath!)]);
      if (t.isNotEmpty) {
        await _api.addAvatarToUser(t.first);
        if (user!.avatarLink == null) return;
        var img =
            await NetworkAssetBundle(Uri.parse("$baseUrl${user!.avatarLink}"))
                .load("$baseUrl${user!.avatarLink}?v=1");
        var avImage = Image.memory(img.buffer.asUint8List());
        avatar = avImage;
        appmodel.avatar = avImage;
      }
    }
  }
}
