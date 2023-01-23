import 'package:photogram_app/ui/widgets/interface_elements/search_bar.dart';
import 'package:photogram_app/ui/widgets/interface_elements/users_feed.dart';
import 'package:photogram_app/ui/widgets/tab_messages/messages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MessagesViewModel>();

    return Scaffold(
        body: SafeArea(
            child: UsersFeed(
                feedUsers: viewModel.users,
                onTap: (id) {}, //!!!!
                titleWidget: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: SearchBar()))));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MessagesViewModel(context: context),
      child: const Messages(),
    );
  }
}
