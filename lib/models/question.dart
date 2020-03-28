import 'package:mathemeister/models/questionAnswer.dart';

class Question {
  String queId;
  String queLevel;
  String queQuestion;
  List<QuestionAnswer> queAnswers = [];
  String queCreationDate;
  String queCreatorUuid;
  String queCreatorFullname;
  String catId;
  String catName;

  bool answered = false;
  bool correct = false;

  Question.fromJson(Map<String, dynamic> jsonMap) {
    this.queId = jsonMap['que_id'];
    this.queLevel = jsonMap['que_level'];
    this.queQuestion = jsonMap['que_question'];
    this.queAnswers.add(QuestionAnswer(answer: jsonMap['que_correctAnswer'], correctAnswer: true));
    this.queAnswers.add(QuestionAnswer(answer: jsonMap['que_wrongAnswerOne'], correctAnswer: false));
    this.queAnswers.add(QuestionAnswer(answer: jsonMap['que_wrongAnswerTwo'], correctAnswer: false));
    this.queAnswers.add(QuestionAnswer(answer: jsonMap['que_wrongAnswerThree'], correctAnswer: false));
    this.queCreationDate = jsonMap['que_creationDate'];
    this.queCreatorUuid = jsonMap['queCreatorUuid'];
    this.queCreatorFullname = jsonMap['que_creatorFullname'];
    this.catId = jsonMap['que_catName'];
    this.catName = jsonMap['que_catId'];
  }
}
