import 'package:photogram_app/ui/media_query.dart';
import 'package:flutter/material.dart';

class ImagesView extends StatelessWidget {
  final List<Image> addedImages;

  const ImagesView({
    Key? key,
    required this.addedImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (addedImages.isEmpty) {
      return const Text("No attaches added",
          textAlign: TextAlign.left,
          style: TextStyle(color: Color.fromRGBO(158, 158, 158, 0.5)));
    }

    return GridView.extent(
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        children: addedImages,
        maxCrossAxisExtent: screenShortestSide(context) / 2);
  }
}
