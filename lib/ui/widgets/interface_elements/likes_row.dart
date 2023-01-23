import 'package:photogram_app/ui/widgets/interface_elements/icon_with_number.dart';
import 'package:flutter/material.dart';

class LikesRow extends StatelessWidget {
  final int likesCount;
  final int commentsCount;
  final int repostsCount;

  const LikesRow(
      {Key? key,
      required this.likesCount,
      required this.commentsCount,
      required this.repostsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconWithNumber(
        iconData: Icons.favorite,
        number: likesCount,
        onPressed: () {},
      ),
      IconWithNumber(
        iconData: Icons.mode_comment,
        number: commentsCount,
        onPressed: () {},
      ),
      IconWithNumber(
        iconData: Icons.repeat,
        number: repostsCount,
        onPressed: () {},
      )
    ]);
  }
}
