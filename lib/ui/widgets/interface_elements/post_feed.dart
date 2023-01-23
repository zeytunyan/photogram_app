import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/ui/widgets/interface_elements/post_item.dart';
import 'package:flutter/material.dart';

class PostFeed extends StatefulWidget {
  final List<PostModel>? feedPosts;
  final void Function(String)? onTap;
  final Widget? titleWidget;
  final ScrollPhysics? physics;

  const PostFeed(
      {Key? key,
      required this.feedPosts,
      this.onTap,
      this.titleWidget,
      this.physics})
      : super(key: key);

  @override
  State<PostFeed> createState() => PostFeedState();
}

class PostFeedState extends State<PostFeed> {
  final scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    setState(() => _isLoading = val);
  }

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    setState(() => _posts = val);
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
        posts = [...posts!, ...posts!];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.feedPosts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    _posts = posts ?? widget.feedPosts;
    final titleWidget = widget.titleWidget;
    final isTitleNotNull = titleWidget != null;
    var count = posts!.length; // !!!!

    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          physics: widget.physics,
          itemCount: count,
          controller: scrollController,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, listIndex) {
            if (isTitleNotNull && listIndex == 0) {
              return titleWidget;
            }

            if (posts == null) {
              return const SizedBox.shrink();
            }

            var post = posts![listIndex];

            return PostItem(
              post: post,
              onTap: widget.onTap == null ? null : () => widget.onTap!(post.id),
            );
          },
        )),
        if (isLoading) const LinearProgressIndicator()
      ],
    );
  }
}
