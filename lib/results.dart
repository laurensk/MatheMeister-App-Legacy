import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/api/apiRequests.dart';
import 'package:mathemeister/appDelegate.dart';
import 'package:mathemeister/game.dart';
import 'package:mathemeister/models/category.dart';
import 'package:mathemeister/models/question.dart';
import 'package:mathemeister/utils/sharedPrefsUtils.dart';
import 'package:mathemeister/utils/ui/alertUtils.dart';
import 'package:mathemeister/utils/ui/questionVisualizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Results extends StatefulWidget {
  final List<Question> questions;
  final int answeredQuestions;
  final int correctQuestions;
  final Category category;
  final int level;

  Results(
      {this.questions,
      this.answeredQuestions,
      this.correctQuestions,
      this.category,
      this.level});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  int minCorrectQuestionsToPassLevel = 8;
  bool congrats;
  int currentLevel;

  @override
  void initState() {
    congrats = widget.correctQuestions >= minCorrectQuestionsToPassLevel;

    if (widget.level != null) {
      currentLevel = widget.level;
      if (widget.correctQuestions >= minCorrectQuestionsToPassLevel) {
        _increaseLevel();
        setState(() {
          currentLevel += 1;
        });
      }
    }

    super.initState();
  }

  _increaseLevel() async {
    final currentLevel = await SharedPrefsUtils.getCurrentLevel();
    final newLevel = currentLevel + 1;
    SharedPrefsUtils.setCurrentLevel(newLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: QuestionVisualizer.questionVisualizer(widget.questions),
          backgroundColor: congrats ? Color(0xff4bc475) : Color(0xffC62424),
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
              _goHome();
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
                _menu();
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
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Image.asset(
                  congrats
                      ? "assets/results/congratulations.png"
                      : "assets/results/gameover.png",
                  width: MediaQuery.of(context).size.width / 2),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Text(
                congrats ? "Gratulation!" : "Schade!",
                style: TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 30,
                  color: congrats ? Color(0xff40a764) : Color(0xffC62424),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Text("Du hast",
                  style: TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 15,
                    color: congrats ? Color(0xff40a764) : Color(0xffC62424),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Text(
                  "${widget.correctQuestions} von ${widget.answeredQuestions} Fragen",
                  style: TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 25,
                    color: congrats ? Color(0xff40a764) : Color(0xffC62424),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Text("richtig beantwortet.",
                  style: TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 15,
                    color: congrats ? Color(0xff40a764) : Color(0xffC62424),
                  )),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              _buttomButtonRetry(),
              _bottomButtonGoHome(),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          )),
        ));
  }

  Widget _buttomButtonRetry() {
    return _buttonBottom(
      (widget.category == null)
          ? _levelPassed()
              ? "Mit Level $currentLevel fortfahren"
              : "Erneut versuchen"
          : "Kategorie erneut üben",
      Colors.white,
      TextStyle(
        fontFamily: "Arial Rounded MT Bold",
        fontSize: 21,
        color: congrats ? Color(0xff40a764) : Color(0xffC62424),
      ),
      _retry,
    );
  }

  bool _levelPassed() {
    return (widget.correctQuestions >= 8);
  }

  _retry() {
    if (widget.category == null) {
      _playLevel();
    } else {
      replayCategory();
    }
  }

  Widget _bottomButtonGoHome() {
    return _buttonBottom(
      "Zurück zum Menü",
      Colors.white,
      TextStyle(
        fontFamily: "Arial Rounded MT Bold",
        fontSize: 21,
        color: congrats ? Color(0xff40a764) : Color(0xffC62424),
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
        )
      ],
    );
  }

  _playLevel() async {
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

    ApiRequests.getQuestionsLvl(currentLevel).then((apiCall) {
      if (apiCall.error) {
        Navigator.pop(context);
        switch (apiCall.apiError.errorCode) {
          case 702:
            AlertUtils.showApiErrorAlert(
                context,
                "Zu wenig Fragen",
                "In diesem Level sind nicht genug Fragen, um ein Spiel zu starten",
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
              builder: (context) => Game(
                questions: questions,
                answeredQuestions: 0,
                correctQuestions: 0,
                category: null,
                level: currentLevel,
              ),
            ));
      }
    });
  }

  replayCategory() async {
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

    ApiRequests.getQuestionsCat(widget.category.catId).then((apiCall) {
      if (apiCall.error) {
        Navigator.pop(context);
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
              builder: (context) => Game(
                  questions: questions,
                  answeredQuestions: 0,
                  correctQuestions: 0,
                  category: widget.category,
                  level: null),
            ));
      }
    });
  }

  _menu() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Problem melden'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text(
                'Problem mit der App melden',
                style: TextStyle(color: Color(0xff4bc475)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _sendMail("MatheMeister%3A%20Problem%20melden%20%28App%29");
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Problem mit einer Frage melden',
                style: TextStyle(color: Color(0xff4bc475)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _sendMail("MatheMeister%3A%20Problem%20melden%20%28Frage%29");
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Erledigt',
              style: TextStyle(color: Color(0xff4bc475)),
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    );
  }

  _sendMail(String subject) async {
    var url = 'mailto:hello@laurensk.at?subject=$subject';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
