import 'package:flutter/material.dart';

class UiUtils {
  static void showErrorAlert(
    BuildContext context, {
    String message = "Something went wrong",
    int time = 7,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: time),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: "Ok",
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      ),
    );
  }
}
