import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
               CircularProgressIndicator(),
              Text('loading'),
            ],
          ),
        );
      });
}

void hideLoading(
  BuildContext context,
) {
  Navigator.of(context).pop();
}

void showMessage(BuildContext context, String message, String posActionText,
    Function posAction, {String? negActionText, Function? negAction}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  posAction();
                },
                child: Text(posActionText))
          ],
        );
      });
}
