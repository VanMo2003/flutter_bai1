import 'package:flutter/material.dart';

Future<void> showDeleteDialog(BuildContext context, Function() onPressed) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        title: const Text('Accept?'),
        content: const Text("Do you accept delete this title?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Yes'),
            onPressed: () {
              onPressed();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
