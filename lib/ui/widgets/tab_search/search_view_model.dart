import 'package:photogram_app/data/services/post_service.dart';
import 'package:photogram_app/ui/navigation/tab_navigator.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/post_model.dart';

class SearchViewModel extends ChangeNotifier {
  BuildContext context;
  final _postService = PostService();

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  SearchViewModel({required this.context}) {
    asyncInit();
  }

  void asyncInit() async {
    posts = await _postService.getAllPosts(0, 5);
  }

  void toPostDetail(String postId) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
  }
}
