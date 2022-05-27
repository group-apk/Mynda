import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel{
  String? qid, question;
  List? answer;

  QuestionModel.fromMap(Map<String, dynamic> data){
    qid = data['qid'];
    question = data['question'];
    answer = data['answer'];
  }

  QuestionModel();

  Map<String, dynamic> toMap(){
    return{
      'qid': qid,
      'question': question,
      'answer': answer
    };
  }
}