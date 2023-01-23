import 'package:photogram_app/ui/widgets/interface_elements/fitted_text.dart';
import 'package:flutter/material.dart';
import 'package:photogram_app/ui/media_query.dart';

class IconWithNumber extends StatelessWidget {
  final IconData iconData;
  final int number;
  final void Function()? onPressed;

  const IconWithNumber(
      {Key? key,
      required this.iconData,
      required this.number,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenMin = screenShortestSide(context);

    return TextButton.icon(
      style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
          fixedSize: Size.fromWidth(screenMin / 10)),
      icon: Icon(iconData, size: screenMin / 20),
      label: FittedText('$number'),
      onPressed: onPressed,
    );
  }
}
