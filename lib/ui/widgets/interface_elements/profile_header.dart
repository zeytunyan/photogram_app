import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/media_query.dart';
import 'package:photogram_app/ui/widgets/interface_elements/fitted_text.dart';
import 'package:flutter/material.dart';

import 'num_with_caption.dart';

class ProfileHeader extends StatelessWidget {
  final int postsCount;
  final int followersCount;
  final int followingsCount;
  final void Function()? onTapPhoto;
  final void Function()? onTapPosts;
  final void Function()? onTapFollowers;
  final void Function()? onTapFollowings;
  final ImageProvider<Object>? foregroundImage;
  final String fullname;
  final String? profession;
  final String? status;
  final Color? color;

  const ProfileHeader(
      {Key? key,
      required this.postsCount,
      required this.followersCount,
      required this.followingsCount,
      required this.onTapPhoto,
      required this.foregroundImage,
      required this.onTapPosts,
      required this.onTapFollowers,
      required this.onTapFollowings,
      required this.fullname,
      this.profession,
      this.status,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color ?? snow,
        elevation: 0.3,
        margin: const EdgeInsets.symmetric(vertical: 1),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicHeight(
                    child: Row(children: [
                  Expanded(
                    child: InkWell(
                        onTap: onTapPhoto,
                        child: CircleAvatar(
                          radius: screenShortestSide(context) / 7,
                          foregroundImage: foregroundImage,
                        )),
                  ),
                  Expanded(
                      child: NumWithCaption(
                          onTap: onTapPosts,
                          num: postsCount,
                          caption: "Posts")),
                  // const SizedBox(width: 5),
                  Expanded(
                      child: NumWithCaption(
                          onTap: onTapFollowers,
                          num: followersCount,
                          caption: "Followers")),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NumWithCaption(
                        onTap: onTapFollowings,
                        num: followingsCount,
                        caption: "Followings"),
                  )
                ])),
                FittedText(fullname,
                    style: mainFont(fontWeight: FontWeight.bold)),
                if (profession != null)
                  FittedText(profession!, style: mainFont(color: Colors.grey)),
                const SizedBox(height: 10),
                if (status != null) FittedText(status!, style: mainFont())
              ]),
        ));
  }
}
