import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? qid, question;
  List? option;

  QuestionModel.fromMap(Map<String, dynamic> data) {
    qid = data['qid'];
    question = data['question'];
    option = data['option'];
  }

  QuestionModel() {
    question = '';
    option = [''];
  }

  Map<String, dynamic> toMap() {
    return {
      'qid': qid,
      'question': question,
      'option': option,
      'createdAt': Timestamp.now()
    };
  }
}
