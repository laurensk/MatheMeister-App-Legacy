import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/api/apiRequests.dart';
import 'package:mathemeister/game.dart';
import 'package:mathemeister/models/apiCall.dart';
import 'package:mathemeister/models/category.dart';
import 'package:mathemeister/models/question.dart';
import 'package:mathemeister/utils/ui/alertUtils.dart';
import 'package:mathemeister/utils/ui/bottomButton.dart';

class ChooseCategory extends StatefulWidget {
  final List<Category> categories;
  ChooseCategory({this.categories});

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  int _selected;

  // @override
  // void initState() {
  //   // Implement initState
  //   super.initState();
  // }

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
                ? FutureBuilder<ApiCall>(
                    future: ApiRequests.getCategories(),
                    builder:
                        (BuildContext context, AsyncSnapshot<ApiCall> apiCall) {
                      switch (apiCall.connectionState) {
                        case ConnectionState.done:
                          return _listView(context, apiCall.data.data);
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
          shape: _selected == index
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: Color(0xff1ab14e),
                    width: 2.0,
                  ),
                )
              : RoundedRectangleBorder(
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
    setState(() {
      _selected = index;
    });

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

    ApiRequests.getQuestionsCat(category.catId).then((apiCall) {
      if (apiCall.error) {
        Navigator.pop(context);
        setState(() {
          _selected = null;
        });
        switch (apiCall.apiError.errorCode) {
          case 702:
            AlertUtils.showApiErrorAlert(
                context,
                "Zu wenig Fragen",
                "Diese Kategorie hat zu wenig Fragen, um ein Spiel zu starten",
                "OK");
            break;
          default:
            AlertUtils.showUnknownApiErrorAlert(context, apiCall.apiError);
        }
      } else {
        List<Question> questions = apiCall.data;
        Navigator.pop(context);
        Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: false,
              builder: (context) => Game(questions: questions, answeredQuestions: 0, correctQuestions: 0, category: category, level: null),
            ));
      }
    });
  }
}
