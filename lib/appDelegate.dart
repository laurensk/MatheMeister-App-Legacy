import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/loading.dart';
import 'package:mathemeister/utils/sharedPrefsUtils.dart';

import 'home.dart';

class AppDelegate extends StatefulWidget {
  @override
  _AppDelegateState createState() => _AppDelegateState();
}

class _AppDelegateState extends State<AppDelegate> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: SharedPrefsUtils.getCurrentLevel(),
        builder: (BuildContext context, AsyncSnapshot<int> level) {
          switch (level.connectionState) {
            case ConnectionState.done:
              return Home(level: level.data);
            break;
            default:
              return Loading();
          }
        });
  }
}
