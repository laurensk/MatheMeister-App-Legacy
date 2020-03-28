import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/appDelegate.dart';
import 'package:mathemeister/models/question.dart';
import 'package:mathemeister/utils/ui/colorUtils.dart';
import 'package:mathemeister/utils/ui/questionVisualizer.dart';
import 'package:page_transition/page_transition.dart';

class Results extends StatefulWidget {
  final List<Question> questions;
  final int answeredQuestions;
  final int correctQuestions;

  Results({this.questions, this.answeredQuestions, this.correctQuestions});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: QuestionVisualizer.questionVisualizer(widget.questions),
          backgroundColor: Color(0xff4bc475),
          leading: CupertinoButton(
            child: Container(
              child: Icon(Icons.home, color: Colors.white),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(7.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.10),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            onPressed: () {
              //_quit();
            },
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Container(
                child: Icon(Icons.menu, color: Colors.white),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(7.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.10),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              onPressed: () {
                //_menu();
              },
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 3, child: Container(),),
              Text("Du hast ${widget.correctQuestions} von ${widget.answeredQuestions} Fragen richtig beantwortet!"),
              Expanded(flex: 3, child: Container(),),
              _buttomButtonRetry(),
              _bottomButtonGoHome(),
              Expanded(flex: 1, child: Container(),),
            ],
          )),
        ));
  }

  Widget _buttomButtonRetry() {
    return _buttonBottom(
      "Erneut versuchen",
      Colors.white,
      TextStyle(
        fontFamily: "Arial Rounded MT Bold",
        fontSize: 21,
        color: Color(0xff40a764),
      ),
      _retry,
    );
  }

  _retry() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight, child: AppDelegate()));
  }

  Widget _bottomButtonGoHome() {
    return _buttonBottom(
      "Zurück zum Menu",
      Colors.white,
      TextStyle(
        fontFamily: "Arial Rounded MT Bold",
        fontSize: 21,
        color: Color(0xff40a764),
      ),
      _goHome,
    );
  }

  _goHome() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight, child: AppDelegate()));
  }

  Widget _buttonBottom(String title, Color backgroundColor, TextStyle textStyle,
      Function onClick) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          onPressed: () {
            onClick();
          },
          child: Container(
            child: Center(child: Text(title, style: textStyle)),
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                width: 2.00,
                color: backgroundColor,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2.00, 2.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                )
              ],
              borderRadius: BorderRadius.circular(30.00),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 55),
        )
      ],
    );
  }
}
