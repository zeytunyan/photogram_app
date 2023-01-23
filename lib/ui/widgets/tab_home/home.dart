import 'package:photogram_app/ui/widgets/interface_elements/post_feed.dart';

import 'package:photogram_app/ui/widgets/tab_home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();

    return Scaffold(
        body: SafeArea(
            child: PostFeed(
                feedPosts: viewModel.posts, onTap: viewModel.toPostDetail)));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(context: context),
      child: const Home(),
    );
  }
}
