import 'package:photogram_app/ui/widgets/interface_elements/error_toast.dart';
import 'package:photogram_app/ui/widgets/interface_elements/success_toast.dart';
import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  void console() {
    if (kDebugMode) {
      print(this);
    }
  }
}

void showToast(
    {required BuildContext context,
    required ToastsEnum toastType,
    required String text}) {
  void show(Toast toast) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(toast);
  }

  switch (toastType) {
    case ToastsEnum.error:
      show(ErrorToast(context: context, text: text));
      break;
    case ToastsEnum.success:
      show(SuccessToast(context: context, text: text));
      break;
    default:
      throw ArgumentError("There are no such toast");
  }
}

Future<bool> showModal(
    {required String title,
    required String content,
    required BuildContext context}) async {
  bool result = false;

  await showDialog(
    context: context,
    builder: (builderContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              child: const Text("Yes"),
              onPressed: () {
                result = true;
                Navigator.of(context, rootNavigator: true).pop('dialog');
              }),
          TextButton(
              child: const Text("No"),
              onPressed: () {
                result = false;
                Navigator.of(context, rootNavigator: true).pop('dialog');
              })
        ],
      );
    },
  );

  return result;
}

class WrongCredentionalException implements Exception {}

class NoNetworkException implements Exception {}

class ServerException implements Exception {}
