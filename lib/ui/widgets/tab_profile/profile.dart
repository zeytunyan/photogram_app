import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/media_query.dart';
import 'package:photogram_app/ui/widgets/interface_elements/fitted_text.dart';
import 'package:photogram_app/ui/widgets/interface_elements/post_feed.dart';
import 'package:photogram_app/ui/widgets/interface_elements/profile_header.dart';
import 'package:photogram_app/ui/widgets/tab_profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ProfileViewModel>();
    final user = viewModel.user;
    if (user == null) {
      return const Scaffold(
          body: SafeArea(child: Center(child: CircularProgressIndicator())));
    }
    return Scaffold(
        //floatingActionButton: ,
        appBar: AppBar(
          titleSpacing: 8,
          actionsIconTheme: const IconThemeData(size: 20),
          title: FittedText(user.nickName, style: mainFont()),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            IconButton(
                icon: const Icon(Icons.logout), onPressed: viewModel.logout),
            IconButton(
                iconSize: 22,
                color: Colors.red[300],
                onPressed: viewModel.deleteUser,
                icon: const Icon(Icons.delete_forever)),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          ProfileHeader(
            postsCount: user.postsCount,
            followersCount: user.followersCount,
            followingsCount: user.followingsCount,
            onTapPhoto: viewModel.changePhoto,
            foregroundImage: viewModel.avatar?.image,
            onTapPosts: () {},
            onTapFollowers: viewModel.toFollowers,
            onTapFollowings: viewModel.toFollowings,
            fullname: user.fullName,
            profession: user.profession,
            status: user.status,
          ),
          LimitedBox(
            maxHeight: screenHeight(context), // !!!!
            child: PostFeed(
              feedPosts: viewModel.posts,
              onTap: viewModel.toPostDetail,
            ),
          )
        ]))));
  }

  static create() => ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context: context),
        child: const Profile(),
      );
}
