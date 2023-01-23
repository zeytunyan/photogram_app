import 'dart:io';

import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/widgets/interface_elements/images_view.dart';
import 'package:photogram_app/ui/widgets/tab_new_post/new_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<NewPostViewModel>();
    final isPlatformAllowsPicking = Platform.isAndroid || Platform.isIOS;
    final addedImages = viewModel.addedImages;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            //child: const Icon(Icons.check),
            onPressed: viewModel.createPost,
            label: Text("Publish", style: mainFont()),
            icon: const Icon(Icons.send),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: ImagesView(addedImages: addedImages)),
                        Expanded(
                            child: TextField(
                          expands: true,
                          maxLength: 500,
                          minLines: null,
                          maxLines: null,
                          controller: viewModel.textController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "The text of the post",
                          ),
                        )),
                      ]))),
          bottomNavigationBar: BottomAppBar(
            //shape: const CircularNotchedRectangle(),
            child: IntrinsicHeight(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const VerticalDivider(),
                Flexible(
                    child: IconButton(
                  iconSize: 30,
                  onPressed: viewModel.addPhotoFromCamera,
                  icon: const Icon(Icons.photo_camera),
                )),
                Flexible(
                    child: IconButton(
                  iconSize: 30,
                  onPressed: isPlatformAllowsPicking
                      ? viewModel.addPhotoFromGallery
                      : () {},
                  icon: const Icon(Icons.photo),
                )),
              ],
            )),
          ),
        ));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NewPostViewModel(context: context),
      child: const NewPost(),
    );
  }
}
