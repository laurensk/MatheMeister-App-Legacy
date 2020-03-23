import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/utils/sharedPrefsUtils.dart';

class DebugUtils {

  static void setLevelTo(BuildContext context) {

    final _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("set level to int"),
          content: Text("give me a level int"),
          actions: <Widget>[
            CupertinoTextField(
              placeholder: "level int",
              controller: _controller,
            ),
            CupertinoDialogAction(
            child: Text('set'),
            onPressed: () {
              int level = int.parse(_controller.text);
              SharedPrefsUtils.setCurrentLevel(level);
              Navigator.of(context).pop();
            },
          ),
          ],
        );
      },
    );

  }

  static void resetLevels(BuildContext context) {
    SharedPrefsUtils.setCurrentLevel(1);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("reset levels - done"),
          content: Text("you're now on level 1"),
          actions: <Widget>[
            CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ],
        );
      },
    );

  }

}