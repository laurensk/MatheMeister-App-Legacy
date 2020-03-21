import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/appDelegate.dart';
import 'package:mathemeister/home.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

void main() => runApp(MatheMeister());

class MatheMeister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      title: "MatheMeister",
      home: AppDelegate(),
    );
  }
}