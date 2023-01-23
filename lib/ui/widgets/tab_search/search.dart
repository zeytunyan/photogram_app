import 'package:photogram_app/ui/widgets/interface_elements/post_feed.dart';
import 'package:photogram_app/ui/widgets/interface_elements/search_bar.dart';
import 'package:photogram_app/ui/widgets/tab_search/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<SearchViewModel>();

    return Scaffold(
        body: SafeArea(
            child: PostFeed(
                feedPosts: viewModel.posts,
                onTap: viewModel.toPostDetail,
                titleWidget: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: SearchBar()))));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchViewModel(context: context),
      child: const Search(),
    );
  }
}
