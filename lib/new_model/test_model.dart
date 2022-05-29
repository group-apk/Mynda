import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_proj/new_model/question_model.dart';

class TestModel {
  String? quizId, quizTitle, quizImgurl;
  List<QuestionModel>? questions = [];

  TestModel.fromMap(Map<String, dynamic> data) {
    quizId = data['quizId'];
    quizTitle = data['quizTitle'];
    quizImgurl = data['quizImgurl'];
    // questions = data['questions'];
  }

  TestModel();

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'quizImgurl': quizImgurl,
      // 'questions': (questions != null) ? questions : <QuestionModel>[],
    };
  }
}
