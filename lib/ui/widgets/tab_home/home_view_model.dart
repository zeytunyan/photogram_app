import 'package:photogram_app/ui/navigation/tab_navigator.dart';
import 'package:flutter/material.dart';

import '../../../data/services/data_service.dart';
import '../../../data/services/sync_service.dart';
import '../../../domain/models/post_model.dart';

class HomeViewModel extends ChangeNotifier {
  BuildContext context;
  final _dataService = DataService();

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  HomeViewModel({required this.context}) {
    asyncInit();
  }

  void asyncInit() async {
    await SyncService().syncFeed();
    posts = await _dataService.getPosts();
  }

  void toPostDetail(String postId) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
  }
}
