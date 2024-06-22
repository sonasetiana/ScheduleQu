import 'package:flutter/material.dart';

showAlertDialog(
  BuildContext context, {
  String title = '',
  String message = '',
  String titleNegButton = 'Tidak',
  String titlePosButton = 'Ya',
  VoidCallback? onNegativeClick,
  VoidCallback? onPositiveClick,
}) {
  // set up the button
  Widget negativeButton = TextButton(
    child: Text(titleNegButton),
    onPressed: () {
      onNegativeClick?.call();
      Navigator.pop(context);
    },
  );

  Widget positiveButton = TextButton(
    child: Text(titlePosButton),
    onPressed: () {
      onPositiveClick?.call();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      negativeButton,
      positiveButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
