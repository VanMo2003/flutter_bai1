import 'package:flutter/material.dart';

Future<void> showAddOrUpdateDialog(
  BuildContext context,
  String titleDialog,
  TextEditingController titleController,
  TextEditingController descriptionController,
  Function() onPressed,
) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        title: Text(titleDialog),
        content: SizedBox(
          height: size.height * 0.3,
          width: size.height * 0.8,
          child: Column(
            children: [
              const Spacer(flex: 1),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    label: const Text(
                      'title',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
              const Spacer(flex: 2),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    label: const Text(
                      'description',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('No'),
            onPressed: () {
              titleController.text = '';
              descriptionController.text = '';
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
