import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/ui/media_query.dart';
import 'package:photogram_app/ui/widgets/interface_elements/likes_row.dart';
import 'package:photogram_app/ui/widgets/interface_elements/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../internal/config/app_config.dart';

class PostItem extends StatefulWidget {
  final PostModel post;
  final void Function()? onTap;
  const PostItem({Key? key, required this.post, this.onTap}) : super(key: key);

  @override
  State<PostItem> createState() => PostItemState();
}

class PostItemState extends State<PostItem> {
  int page = 0;
  int count = 1;

  @override
  void initState() {
    super.initState();
    count = widget.post.contents.length;
  }

  void onPageChanged(int pageIndex) {
    setState(() => page = pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    var screenMin = screenShortestSide(context);
    final post = widget.post;
    final avatarLink = post.author.avatarLink;

    return Container(
      padding: const EdgeInsets.all(5),
      height: screenHeight(context) * 0.65,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.all(5),
            title: Text(post.author.nickName),
            subtitle: Text(DateFormat("dd.MM.yyyy").format(post.created)),
            leading: CircleAvatar(
                radius: screenMin / 15,
                foregroundImage: avatarLink == null
                    ? null
                    : NetworkImage(
                        "$baseUrl$avatarLink",
                      ))),
        Expanded(
          child: GestureDetector(
            onTap: widget.onTap,
            child: PageView.builder(
              onPageChanged: onPageChanged,
              itemCount: count,
              itemBuilder: (_, pageIndex) {
                final contentLink = post.contents[pageIndex].contentLink;
                return Image(image: NetworkImage("$baseUrl$contentLink"));
              },
            ),
          ),
        ),
        if (count > 1)
          Padding(
              padding: const EdgeInsets.all(10),
              child: PageIndicator(
                  count: count, current: page, width: screenMin / 45)),
        if (post.text != null)
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                post.text!,
                textAlign: TextAlign.left,
              )),
        LikesRow(
            likesCount: post.likesCount,
            commentsCount: post.commentsCount,
            repostsCount: post.repostsCount)
      ]),
    );
  }
}
