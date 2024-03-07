import 'package:flutter/material.dart';

Future<void> errorAlertDialog(BuildContext context, String? message) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(message!),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
