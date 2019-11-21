import 'package:flutter/material.dart';

class ErrorDialog {
  static void show({
    @required BuildContext context,
    @required String message,
    VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            RaisedButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.pop(dialogContext);
                onOk?.call();
              },
            ),
          ],
        );
      },
    );
  }
}
