import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/api/apiRequests.dart';
import 'package:mathemeister/chooseCategory.dart';
import 'package:mathemeister/models/apiCall.dart';
import 'package:mathemeister/models/category.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

import 'appInfos.dart';

class Home extends StatefulWidget {
  final int level;

  Home({this.level});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Category> preloadedCategories;

  @override
  void initState() {

    _preloadCategories();

    super.initState();
  }

  void _preloadCategories() async {
    ApiCall apiCall = await ApiRequests.getCategories();
    preloadedCategories = apiCall.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.mmMain,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Text(
              "MatheMeister",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial Rounded MT Bold",
                fontSize: 38,
                color: Color(0xffffffff),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Image.asset(
              "assets/logo/c3.png",
              width: 158,
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            CupertinoButton(
              onPressed: () {
              },
              child: Container(
                child: Center(
                    child: Text(
                  "Level ${widget.level}",
                  style: TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 21,
                    color: Color(0xff40a764),
                  ),
                )),
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(
                    width: 2.00,
                    color: Color(0xffffffff),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2.00, 2.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30.00),
                ),
              ),
            ),
            CupertinoButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => ChooseCategory(categories: preloadedCategories,),
                  ),
                );
                },
                child: Container(
                  child: Center(
                      child: Text(
                    "Kategorie üben",
                    style: TextStyle(
                      fontFamily: "Arial Rounded MT Bold",
                      fontSize: 21,
                      color: Color(0xffffffff),
                      shadows: [
                        Shadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  )),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    color: ColorUtils.mmMain,
                    border: Border.all(
                      width: 2.00,
                      color: Color(0xffffffff),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2.00, 2.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30.00),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AppInfos(),
                  ),
                );
              },
              child: Text(
                "Über MatheMeister",
                style: TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 15,
                  color: Color(0xffffffff),
                  letterSpacing: 0.3,
                  shadows: [
                    Shadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
