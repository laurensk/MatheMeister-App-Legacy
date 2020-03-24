import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/api/getCategories.dart';
import 'package:mathemeister/models/category.dart';
import 'package:mathemeister/utils/ui/bottomButton.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';

class ChooseCategory extends StatefulWidget {
  final List<Category> categories;
  ChooseCategory({this.categories});

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomButtonStd(),
        appBar: AppBar(
          title: Text("Kategorie auswählen"),
          backgroundColor: Color(0xff4bc475),
          leading: Container(),
        ),
        body: Container(
          child: Center(
            child: widget.categories == null
                ? FutureBuilder<List<Category>>(
                    future: GetCategories.getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Category>> categories) {
                      switch (categories.connectionState) {
                        case ConnectionState.done:
                          return _listView(context, categories.data);
                          break;
                        default:
                          return _loading();
                      }
                    })
                : _listView(context, widget.categories),
          ),
        ));
  }

  Widget _loading() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(),
        ),
        CupertinoActivityIndicator(
          animating: true,
          radius: 30,
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
      ],
    ));
  }

  Widget _listView(BuildContext context, List<Category> categories) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 130),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            Category category = categories[index];
            return _category(context, index, category);
          }),
    );
  }

  Widget _category(BuildContext context, int index, Category category) {
    return Container(
      child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: InkWell(
              onTap: () {
                _categorySelected(category, index);
              },
              child: Container(
                  height: 73,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                      Text(
                        category.catName,
                        style: TextStyle(
                          fontFamily: "Arial Rounded MT Bold",
                          fontSize: 18,
                          color: Color(0xff313131),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: 94.00,
                        decoration: BoxDecoration(
                          color: Color(0xff4dd17b),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.00),
                            bottomRight: Radius.circular(8.00),
                          ),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              category.catQuestions,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Arial Rounded MT Bold",
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                            ),
                            Text(
                              category.catQuestions == "1" ? "Frage" : "Fragen",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Arial Rounded MT Bold",
                                fontSize: 13,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ))))),
    );
  }

  _categorySelected(Category category, int index) async {
    print("you have selected the category: " +
        index.toString() +
        " on the server: cat_id: " +
        category.catId);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: CupertinoActivityIndicator(
            animating: true,
            radius: 15,
          ),
        );
      },
    );

  // create getQuestions.dart and get 10 questions for this category
    GetCategories.getCategories().then((result) {
      print(result);
      Navigator.pop(context);
      // navigator push Game(questions)
    });
  }
}
