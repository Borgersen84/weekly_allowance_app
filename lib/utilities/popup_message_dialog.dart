import 'package:flutter/material.dart';

class PopupMessageDialog {
  static showAlertDialog(BuildContext context, String message) {
    final String title = "Woopsie..";
    final String buttonText = "OK";

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(buttonText),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
