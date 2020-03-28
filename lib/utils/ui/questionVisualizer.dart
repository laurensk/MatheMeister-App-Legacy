import 'package:flutter/material.dart';
import 'package:mathemeister/models/question.dart';

class QuestionVisualizer {
  static Widget questionVisualizer(List<Question> questions) {
    List<Widget> dots = List<Widget>();

    for (var question in questions) {
      dots.add(_questionDot(question.answered, question.correct));
      dots.add(Padding(padding: EdgeInsets.symmetric(horizontal: 2)));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: dots,
    );
  }

  static Widget _questionDot(bool answered, bool correct) {
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
}
