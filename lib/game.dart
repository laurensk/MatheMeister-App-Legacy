import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/appDelegate.dart';
import 'package:mathemeister/models/question.dart';
import 'package:mathemeister/models/questionAnswer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Game extends StatefulWidget {
  final List<Question> questions;
  final int answeredQuestions;
  final int correctQuestions;

  Game({this.questions, this.answeredQuestions, this.correctQuestions});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  QuestionAnswer _selected;
  Question _currentQuestion;

  int _answeredQuestions;
  int _correctQuestions;

  @override
  void initState() {
    _answeredQuestions = widget.answeredQuestions;
    _correctQuestions = widget.correctQuestions;

    _currentQuestion = widget.questions[widget.answeredQuestions];
    _currentQuestion.queAnswers.shuffle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _questionVisualizer(),
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
              _quit();
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                _questionBox(),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                _answerCard(0, "A", _currentQuestion.queAnswers[0]),
                _answerCard(1, "B", _currentQuestion.queAnswers[1]),
                _answerCard(2, "C", _currentQuestion.queAnswers[2]),
                _answerCard(3, "D", _currentQuestion.queAnswers[3]),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                _nextButton(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ],
            ))));
  }

  Widget _nextButton() {
    return CupertinoButton(
      onPressed: () {
        if (_selected != null) {
          _answerSelected(_selected);
        }
      },
      pressedOpacity: _selected != null ? 0.4 : null,
      child: Container(
        child: Center(
            child: Text(
          "Überprüfen",
          style: _selected != null
              ? TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 21,
                  shadows: [
                    Shadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  color: Color(0xffffffff),
                )
              : TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 21,
                  color: Color(0xff7C7C7C),
                ),
        )),
        height: 50,
        width: MediaQuery.of(context).size.width - 100,
        decoration: _selected != null
            ? BoxDecoration(
                color: Color(0xff4DD17B),
                border: Border.all(
                  width: 2.00,
                  color: Color(0xff4DD17B),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.00, 2.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(30.00),
              )
            : BoxDecoration(
                color: Color(0xffD5D5D5),
                border: Border.all(
                  width: 2.00,
                  color: Color(0xffD5D5D5),
                ),
                borderRadius: BorderRadius.circular(30.00),
              ),
      ),
    );
  }

  Widget _questionBox() {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 230,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Frage ${widget.answeredQuestions + 1} von 10",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial Rounded MT Bold",
                fontSize: 13,
                color: Color(0xff313131),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Text(
              _currentQuestion.queQuestion,
              style: TextStyle(
                fontFamily: "Arial Rounded MT Bold",
                fontSize: 17,
                color: Color(0xff313131),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Text(
              _currentQuestion.catName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial Rounded MT Bold",
                fontSize: 13,
                color: Color(0xff313131),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _answerCard(int id, String letter, QuestionAnswer questionAnswer) {
    return Card(
        elevation: 4,
        shape: _selected == questionAnswer
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
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
        child: InkWell(
            onTap: () {
              setState(() {
                _selected = questionAnswer;
              });
            },
            child: Container(
                height: 73,
                width: MediaQuery.of(context).size.width - 50,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50.00,
                      decoration: BoxDecoration(
                        color: Color(0xff4dd17b),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.00),
                          bottomLeft: Radius.circular(8.00),
                        ),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            letter,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Arial Rounded MT Bold",
                              fontSize: 30,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width - 130,
                            child: Text(
                              questionAnswer.answer,
                              style: TextStyle(
                                fontFamily: "Arial Rounded MT Bold",
                                fontSize: 14,
                                color: Color(0xff313131),
                              ),
                            )),
                      ],
                    )
                  ],
                )))));
  }

  Widget _questionVisualizer() {
    List<Widget> dots = List<Widget>();

    for (var question in widget.questions) {
      dots.add(_questionDot(question.answered, question.correct));
      dots.add(Padding(padding: EdgeInsets.symmetric(horizontal: 2)));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dots,
    );
  }

  Widget _questionDot(bool answered, bool correct) {
    return Container(
      child: answered
          ? Icon(correct ? Icons.check : Icons.close, size: 15)
          : Container(),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: answered
            ? (correct ? Color(0xff64C133) : Color(0xffF44545))
            : Color(0xffEFEFEF),
        border: Border.all(
          width: 2,
          color: Color(0xffffffff),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(5.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        shape: BoxShape.circle,
      ),
    );
  }

  _answerSelected(QuestionAnswer questionAnswer) {
    if (questionAnswer.correctAnswer) {
      widget.questions[widget.answeredQuestions].answered = true;
      widget.questions[widget.answeredQuestions].correct = true;
      _currentQuestion.answered = true;
      _currentQuestion.correct = true;
      setState(() {
        _answeredQuestions += 1;
        _correctQuestions += 1;
      });
    } else {
      widget.questions[widget.answeredQuestions].answered = true;
      widget.questions[widget.answeredQuestions].correct = false;
      _currentQuestion.answered = true;
      _currentQuestion.correct = false;
      setState(() {
        _answeredQuestions += 1;
      });
    }
  }

  _nextQuestion() {
    if (_answeredQuestions <= 9) {
      Navigator.push(
          context,
          CupertinoPageRoute(
            fullscreenDialog: false,
            builder: (context) => Game(
                questions: widget.questions,
                answeredQuestions: _answeredQuestions,
                correctQuestions: _correctQuestions),
          ));
    } else {
      print("du bist fertig");
    }
  }

  _quit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Bist du sicher?"),
          content: Text(
              "Wenn du das Spiel jetzt abbrichst, wird dein in dieser Runde erspielter Fortschritt nicht gespeichert."),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Bleiben'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Verlassen'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: AppDelegate()));
              },
            ),
          ],
        );
      },
    );
  }

  _menu() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Über diese Frage'),
          //message: const Text('Diese Frage wurde von STUEKLER Elke am 24.03.2020 erstellt.'),
          message: const Text(
              'Autor: STUEKLER Elke\nDatum: 24.03.2020\nKategorie: Bruchterme'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text(
                'Problem mit der Frage melden',
                style: TextStyle(color: Color(0xff4bc475)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _sendMail("MatheMeister%3A+Problem+melden+%28Frage%29");
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Problem mit der App melden',
                style: TextStyle(color: Color(0xff4bc475)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _sendMail("MatheMeister%3A+Problem+melden+%28App%29");
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'debug: next question',
                style: TextStyle(color: Color(0xff4bc475)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _nextQuestion();
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
