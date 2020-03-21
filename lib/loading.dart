import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.mmMain,
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/logo/c3.png",
            width: 200,
            height: 200,)
        ),
      ),
    );
  }
}
