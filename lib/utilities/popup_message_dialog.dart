import 'package:flutter/material.dart';

class PopupMessageDialog {
  static showAlertDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      title: Text("Woopsie.."),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
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
