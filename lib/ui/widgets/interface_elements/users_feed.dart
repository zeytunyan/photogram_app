import 'package:photogram_app/domain/models/user_short.dart';
import 'package:photogram_app/internal/config/app_config.dart';
import 'package:photogram_app/ui/media_query.dart';
import 'package:flutter/material.dart';

class UsersFeed extends StatefulWidget {
  final List<UserShort>? feedUsers;
  final void Function(String)? onTap;
  final Widget? titleWidget;

  const UsersFeed({
    Key? key,
    required this.feedUsers,
    this.onTap,
    this.titleWidget,
  }) : super(key: key);

  @override
  State<UsersFeed> createState() => UsersFeedState();
}

class UsersFeedState extends State<UsersFeed> {
  final scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    setState(() => _isLoading = val);
  }

  List<UserShort>? _users;
  List<UserShort>? get users => _users;
  set users(List<UserShort>? val) {
    setState(() => _users = val);
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var max = scrollController.position.maxScrollExtent;
      var percent = scrollController.offset / max * 100;
      if (percent <= 80 || isLoading) return;
      isLoading = true;
      Future.delayed(const Duration(seconds: 1)).then((_) {
        isLoading = false;
        users = [...users!, ...users!];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.feedUsers == null) {
      return const Center(
          child: Text("Nothing to show",
              style: TextStyle(color: Color.fromRGBO(158, 158, 158, 0.5))));
    }

    _users = users ?? widget.feedUsers;
    final titleWidget = widget.titleWidget;
    final isTitleNotNull = titleWidget != null;
    var count = users!.length; //!!!!

    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          itemCount: count,
          controller: scrollController,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, listIndex) {
            if (isTitleNotNull && listIndex == 0) {
              return titleWidget;
            }

            if (users == null) {
              return const SizedBox.shrink();
            }

            final user = users![listIndex];
            final avatarLink = user.avatarLink;

            return ListTile(
                onTap:
                    widget.onTap == null ? null : () => widget.onTap!(user.id),
                contentPadding: const EdgeInsets.all(5),
                title: Text(user.nickName),
                subtitle: Text(user.fullName),
                leading: CircleAvatar(
                    radius: screenShortestSide(context) / 15,
                    foregroundImage: avatarLink == null
                        ? null
                        : NetworkImage(
                            "$baseUrl${user.avatarLink}",
                          )));
          },
        )),
        if (isLoading) const LinearProgressIndicator()
      ],
    );
  }
}
