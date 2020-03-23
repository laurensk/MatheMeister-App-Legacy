import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/utils/debugUtils.dart';
import 'package:mathemeister/utils/ui/bottomButton.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

class AppInfos extends StatefulWidget {
  @override
  AppInfosState createState() => AppInfosState();
}

class AppInfosState extends State<AppInfos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomButton(
          title: "Zurück",
          backgroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: "Arial Rounded MT Bold",
            fontSize: 21,
            color: Color(0xff40a764),
          ),
        ),
        appBar: AppBar(
          title: Text("Über MatheMeister"),
          backgroundColor: Color(0xff4bc475),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Entwickler",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontSize: 20,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Laurens Kropf",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kontakt",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontSize: 20,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "hello@laurensk.at",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Idee",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontSize: 20,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Elke Stückler",
                        style: TextStyle(
                          color: Color(0xff40a764),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  Image.asset(
                    "assets/logo/c2.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  Text(
                    "© 2020 MatheMeister",
                    style: TextStyle(
                      fontFamily: "Arial Rounded MT Bold",
                      color: Color(0xff40a764),
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text("set level to", style: TextStyle(color: Color(0xffF2F2F2)),),
                        onPressed: () {
                          DebugUtils.setLevelTo(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text("reset levels", style: TextStyle(color: Color(0xffF2F2F2)),),
                        onPressed: () {
                          DebugUtils.resetLevels(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
