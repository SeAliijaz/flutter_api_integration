import 'package:flutter/material.dart';

class AppConsts {
  /// Show a custom dialog with a message
  static void showMessage(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SelectableText(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close!"),
            ),
          ],
        );
      },
    );
  }

  ///info message
  static const String infoMessage =
      "Email: eve.holt@reqres.in\nPassword: pistol";
}
