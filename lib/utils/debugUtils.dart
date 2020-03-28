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
          title: Text("log in"),
          content: Text("log in to use debug features"),
          actions: <Widget>[
            CupertinoTextField(
              placeholder: "password",
              controller: _controller,
              obscureText: true,
            ),
            CupertinoDialogAction(
              child: Text('login'),
              onPressed: () {
                if (_controller.text == "mmdevdebug1223") {
                  Navigator.of(context).pop();
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
                } else {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text("nope"),
                        content: Text("wrong password... sorry!!"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('okay'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void resetLevels(BuildContext context) {
    final _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("log in"),
          content: Text("log in to use debug features"),
          actions: <Widget>[
            CupertinoTextField(
              placeholder: "password",
              controller: _controller,
              obscureText: true
            ),
            CupertinoDialogAction(
              child: Text('login'),
              onPressed: () {
                if (_controller.text == "mmdevdebug1223") {
                  Navigator.of(context).pop();
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
                } else {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text("nope"),
                        content: Text("wrong password... sorry!!"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('okay'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
