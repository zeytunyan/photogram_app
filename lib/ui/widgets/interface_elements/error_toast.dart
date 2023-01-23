import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';
import 'package:flutter/material.dart';

class ErrorToast extends Toast {
  ErrorToast({Key? key, required BuildContext context, required String text})
      : super(
            key: key,
            context: context,
            text: text,
            label: "╳",
            backgroundColor: Colors.redAccent[100],
            textColor: Colors.red[900],
            borderColor: Colors.red[900],
            actionColor: Colors.red[900]);
}
