import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';
import 'package:flutter/material.dart';

class SuccessToast extends Toast {
  SuccessToast({Key? key, required BuildContext context, required String text})
      : super(
            key: key,
            context: context,
            text: text,
            label: "✔",
            backgroundColor: Colors.greenAccent,
            textColor: Colors.blueGrey[800],
            actionColor: Colors.blueGrey[800],
            borderColor: Colors.blueGrey[800]);
}
