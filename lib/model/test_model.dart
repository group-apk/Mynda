import 'package:mynda/model/question_model.dart';

class TestModel {
  String? quizId, quizTitle, quizImgurl;
  List<QuestionModel>? questions = [];

  TestModel.fromMap(Map<String, dynamic> data) {
    quizId = data['quizId'];
    quizTitle = data['quizTitle'];
    quizImgurl = data['quizImgurl'];
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
