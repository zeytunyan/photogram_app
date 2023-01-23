import 'package:photogram_app/data/services/post_service.dart';
import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/widgets/interface_elements/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PostDetailsViewModel extends ChangeNotifier {
  final _postService = PostService();
  BuildContext context;
  final String? postId;

  PostDetailsViewModel({required this.context, this.postId}) {
    asyncInit();
  }

  PostModel? _post;
  PostModel? get post => _post;
  set post(PostModel? val) {
    _post = val;
    notifyListeners();
  }

  void asyncInit() async {
    if (postId == null) return;
    post = await _postService.getPost(postId!);
  }
}

class PostDetails extends StatelessWidget {
  const PostDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(royalBlueStatusBar); //!!!!
    var viewModel = context.watch<PostDetailsViewModel>();

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: viewModel.post == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: PostItem(post: viewModel.post!, onTap: null))));
  }

  static create(Object? arg) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostDetailsViewModel(
          context: context, postId: arg is String? ? arg : null),
      child: const PostDetails(),
    );
  }
}
