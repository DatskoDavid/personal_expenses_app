import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String title;
  final Function handler;

  AdaptiveTextButton({
    required this.title,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            onPressed: () => handler(),
            child: Text(
              'Choose date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(),
          )
        : CupertinoButton(
            onPressed: () => handler(),
            child: Text(
              'Choose date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
