import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/widgets/interface_elements/fitted_text.dart';
import 'package:flutter/material.dart';

class NumWithCaption extends StatelessWidget {
  final int num;
  final String caption;
  final void Function()? onTap;

  const NumWithCaption({
    Key? key,
    required this.num,
    required this.caption,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedText("$num",
              style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          FittedText(caption, style: mainFont()),
        ],
      ),
    );
  }
}
