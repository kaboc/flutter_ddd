import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    @required BuildContext context,
    @required this.message,
    this.onConfirm,
  }) : _context = context;

  final BuildContext _context;
  final String message;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error', style: TextStyle(color: Colors.red)),
      content: Text(message),
      actions: <Widget>[
        RaisedButton(
          child: const Text('OK', style: TextStyle(color: Colors.white)),
          color: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
        ),
      ],
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }
}
