import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

class AppInfos extends StatefulWidget {
  @override
  AppInfosState createState() => AppInfosState();
}

class AppInfosState extends State<AppInfos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xff40a764),
                            ),
                          ),
                          Text(
                            "Über die App".toUpperCase(),
                            style: TextStyle(
                              color: Color(0xff40a764),
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                            ),
                          ),
                        ]),
                  ],
                ),
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
                      // fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "Laurens Kropf",
                    style: TextStyle(
                      color: Color(0xff40a764),
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w700,
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
                      // fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "hello@laurensk.at",
                    style: TextStyle(
                      color: Color(0xff40a764),
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w700,
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
                      // fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "Elke Stückler",
                    style: TextStyle(
                      color: Color(0xff40a764),
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w700,
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
                  Expanded(child: Container()),
                  Text(
                    "© 2020",
                    style: TextStyle(
                      color: Color(0xff40a764),
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
