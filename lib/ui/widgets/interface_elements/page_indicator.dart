import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator(
      {Key? key, required this.count, required this.current, this.width = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon createCircle(int i) {
      final size = i == (current ?? 0) ? width * 1.4 : width;
      return Icon(Icons.circle, size: size, color: Colors.grey.shade700);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [for (var i = 0; i < count; i++) createCircle(i)],
    );
  }
}
