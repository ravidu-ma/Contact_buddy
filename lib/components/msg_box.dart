import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert(
      {Key? key, required this.title, required this.msg, required this.btnText})
      : super(key: key);

  final String title;
  final String msg;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [Text(msg)],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(btnText)),
      ],
    );
  }
}
