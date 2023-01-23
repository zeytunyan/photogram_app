import 'package:flutter/material.dart';

import '../../media_query.dart';

enum ToastsEnum {
  error,
  success,
}

class Toast extends SnackBar {
  Toast({
    Key? key,
    required BuildContext context,
    required String text,
    required String label,
    Color? backgroundColor,
    Color? borderColor,
    Color? actionColor,
    Color? textColor,
  }) : super(
            key: key,
            backgroundColor: backgroundColor,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.none,
            elevation: 5,
            duration: const Duration(seconds: 5),
            margin: EdgeInsets.symmetric(
                vertical: screenHeight(context) * 0.15,
                horizontal: screenWidth(context) * 0.1),
            shape: StadiumBorder(
                side: BorderSide(
                    strokeAlign: StrokeAlign.inside,
                    color: borderColor ?? const Color(0xFF000000))),
            action: SnackBarAction(
              textColor: actionColor,
              label: label,
              onPressed: () {},
            ),
            content: Text(text,
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: textColor)));




}
